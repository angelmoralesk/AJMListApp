//
//  AJMFlowLayout.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 05/09/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

protocol AJMFlowLayoutDelegate : class {
    
    func ajmFlowLayout(sender : AJMFlowLayout, didChooseIndex index : Int)
    
}

class AJMFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns = 6
    var allAttributes = [IndexPath : UICollectionViewLayoutAttributes]()
    var xOffsets = [CGFloat]()
    var yOffsets = [CGFloat]()
    
    weak var delegate : AJMFlowLayoutDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        itemSize = CGSize(width: 300, height: 300)
    }
    
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        collectionView?.decelerationRate = UIScrollViewDecelerationRateNormal

    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var newOffset = CGPoint()
        
        let firstItemPosX = layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!.frame.origin.x
        let secondItemPosX = layoutAttributesForItem(at: IndexPath(item: 0, section: 1))!.frame.origin.x
        
        let spacing = secondItemPosX - firstItemPosX - itemSize.width + collectionView!.contentInset.left

        let width = itemSize.width + spacing
        //print("\(spacing)")
        var offset = proposedContentOffset.x
        //print("Imprimiendo \(velocity) \(width) - \(offset)")

        var index = 0
        
        
        if velocity.x > 0 {
            offset = width * ceil(offset / width)
            index = Int(ceil(offset / width))
        } else if velocity.x == 0 {
            offset = width * round(offset / width)
            index = Int(round(offset / width))
        } else if velocity.x < 0 {
            offset = width * floor(offset / width)
            index = Int(floor(offset / width))
        }
        
        delegate?.ajmFlowLayout(sender: self, didChooseIndex: index)
        
        newOffset.x = offset
        newOffset.y = proposedContentOffset.y
        
        return newOffset
        
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
            
            // create 3D effect
            var transform = CATransform3DIdentity
            transform.m34 = -1.0 / 500.0
            transform = CATransform3DRotate(transform, CGFloat(M_PI_4) * percent, 0, 1, 0)
            if attribute.indexPath.section != 0 {
                if percent >= 0.5 {
                    attribute.alpha = 1
                } else {
                    attribute.alpha = attribute.alpha*percent
                }
                
            }
            
           // print("layoutAttributesForElements \(attribute.indexPath.section)frame  \(attribute.frame) - \(percent) %")

            attribute.transform3D = transform
            
            layoutAttributes.append(attribute)
        }
 
        let firstItemPosX = layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!.frame.origin.x
        let secondItemPosX = layoutAttributesForItem(at: IndexPath(item: 0, section: 1))!.frame.origin.x
        
       

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
            if let _ = allAttributes[attr.indexPath] {
                
            } else {
                
                let posY = (collectionView!.bounds.height - itemSize.height) / 2
                attr.frame = CGRect(x: attr.frame.origin.x, y: posY, width: itemSize.width, height: itemSize.height)
                allAttributes.updateValue(attr, forKey: attr.indexPath)
                
            }
            
        }
    }
}
