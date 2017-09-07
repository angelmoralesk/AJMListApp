//
//  CountryCell.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 10/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
}
