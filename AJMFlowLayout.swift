//
//  AJMFlowLayout.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 05/09/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class AJMFlowLayout: UICollectionViewFlowLayout {
    
    var allAttributes = [IndexPath : UICollectionViewLayoutAttributes]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        itemSize = CGSize(width: 300, height: 300)
    }
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect)!
        
        setUpInitialPositionForLayoutAttributes(array)
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for (_, value) in allAttributes {
            
            var posX = value.frame.origin.x + collectionView!.contentInset.left
            var percent : CGFloat = 0
            if collectionView!.contentOffset.x >= posX {
                posX = collectionView!.contentOffset.x + collectionView!.contentInset.left
                percent = min(abs(collectionView!.contentOffset.x / (posX + itemSize.width)), 1.0)
            }
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: value.indexPath)
            attribute.frame = CGRect(x: posX, y: value.frame.origin.y, width: itemSize.width, height: itemSize.height)
            
           addRotateEffect(attribute: attribute, percent: percent)
            
            layoutAttributes.append(attribute)
        }


        return layoutAttributes
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
   
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let value = allAttributes[indexPath] {
            return value
        }
        return UICollectionViewLayoutAttributes()
    }

    //MARK :- HELPER FUNCTIONS
    
    func setUpInitialPositionForLayoutAttributes(_ attributes : [UICollectionViewLayoutAttributes]) {
        
        for attr in attributes {
            if let _ = allAttributes[attr.indexPath] { } else {
                
                let posY = (collectionView!.bounds.height - itemSize.height) / 2
                attr.frame = CGRect(x: attr.frame.origin.x, y: posY, width: itemSize.width, height: itemSize.height)
                allAttributes.updateValue(attr, forKey: attr.indexPath)
                
            }
            
        }
    }
    
    func addRotateEffect(attribute : UICollectionViewLayoutAttributes, percent : CGFloat) {
        // create 3D effect
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        transform = CATransform3DRotate(transform, CGFloat(M_PI_4) * percent, 0, 1, 0)
        if attribute.indexPath.section != 0 {
            if percent >= 0.5 {
                attribute.alpha = 1
            } else {
                attribute.alpha = 0
            }
        }
        
        attribute.transform3D = transform
    }
}
