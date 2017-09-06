//
//  ViewController.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 09/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit
import IGListKit

class EuropeVisualizerViewController: UIViewController {

    var names = ["berlin-cathedral","brandenburg-gate","colosseum", "eiffel", "notre-dame", "venice"]
    var places : [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var currentCountry : Country = CountryFactory.countryByIndex(index: 0)
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        names = names.map { $0.appending(".jpg") }
        
        adapter.collectionView = collectionView
        adapter.scrollViewDelegate = self
        adapter.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? AJMFlowLayout {
            layout.delegate = self
        }
        
    }

}

extension EuropeVisualizerViewController : ListAdapterDataSource {
    
    // 1
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return names as [ListDiffable]
    }
    
    // 2
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is String {
            return PlaceListController()
        }
        return ListSectionController()
    }
    
    // 3
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
}

extension EuropeVisualizerViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionView = scrollView as! UICollectionView
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startingScrollingOffset = scrollView.contentOffset // 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //source : https://rolandleth.com/uicollectionview-snap-scrolling-and-pagination
        let offset = scrollView.contentOffset.x + scrollView.contentInset.left // 2
        
        let collectionView = scrollView as! UICollectionView
        let layout = collectionView.collectionViewLayout as? AJMFlowLayout
        let cellWidth = layout!.itemSize.width
        let proposedPage = offset / max(1, cellWidth)
        let snapPoint: CGFloat = 0.1
        let snapDelta: CGFloat = offset > startingScrollingOffset.x ? (1 - snapPoint) : snapPoint
        
        if floor(proposedPage + snapDelta) == floor(proposedPage) { // 3
            page = floor(proposedPage) // 4
        }
        else {
            page = floor(proposedPage + 1) // 5
        }
        
        targetContentOffset.pointee = CGPoint(
            x: cellWidth * page,
            y: targetContentOffset.pointee.y
        )
        
        // BEFORE let index = (cellWidth * page) / 368
        let index = (cellWidth * page) / layout!.allAttributes[IndexPath(row: 0, section:1)]!.frame.origin.x
        let country = CountryFactory.countryByIndex(index: Int(index))
        titleLabel.text = country.name
        descriptionTextView.text = country.description

    }
    
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView!.collectionViewLayout.invalidateLayout()
    }
    
  
}



