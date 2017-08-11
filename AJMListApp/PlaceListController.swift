//
//  CountryListController.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 10/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import IGListKit

class PlaceListController : ListSectionController {
    
    var name : String!
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        let width = context.containerSize.width
        let height = context.containerSize.height
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "cell",
                                                                              for: self,
                                                                              at: index) as? CountryCell else {
                                                                                fatalError()
        }
        cell.imageView.image = UIImage(named: name)
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }
    
    override func didUpdate(to object: Any) {
        name = object as! String
    }
    
    override func didSelectItem(at index: Int) {
    }

}
