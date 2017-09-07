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

    let itemSize = CGSize(width: 300, height: 300)
    var attributesList = [CircularCollectionViewLayoutAttributes]()

    var radius : CGFloat = 500 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem : CGFloat {
        return atan(itemSize.width / 200)
    }
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
            -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width -
            collectionView!.bounds.width)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width, height: collectionView!.bounds.height)
    }
    
    override class var layoutAttributesClass: Swift.AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }

    override func prepare() {
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height

        
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map { (i)
            -> CircularCollectionViewLayoutAttributes in
            // 1
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

            // 2
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.midY)
            // 3
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            return attributes
        }

    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

