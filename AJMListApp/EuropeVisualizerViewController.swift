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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView!.collectionViewLayout.invalidateLayout()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        titleLabel.text = currentCountry.name
        descriptionTextView.text = currentCountry.description
    }
}

extension EuropeVisualizerViewController : AJMFlowLayoutDelegate {
    
    func ajmFlowLayout(sender: AJMFlowLayout, didChooseIndex index: Int) {
        let country = CountryFactory.countryByIndex(index: index)
        currentCountry = country
    }
}

