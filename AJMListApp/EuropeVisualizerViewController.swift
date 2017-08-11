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
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        names = names.map { $0.appending(".jpg") }
        /*places = placesNames.flatMap{ name in
            return UIImage(named: name)
        }*/
        
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
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

