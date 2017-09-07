//
//  AJMCircularLayout.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 07/09/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class CircularCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle : CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)

        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
    
    
    
}


class AJMCircularLayout: UICollectionViewLayout {

}
