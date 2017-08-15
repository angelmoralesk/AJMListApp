//
//  AJMLayout.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 12/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class AJMLayout: UICollectionViewLayout {
    
    private var attributes = [NSIndexPath : UICollectionViewLayoutAttributes]()
    private let itemSize : CGSize = CGSize(width: 300, height: 300)
    
    private var numberOfColumns = 6
    private var cellPadding : CGFloat = 10
    private var contentHeight : CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.height - (insets.bottom + insets.top)
        }
    }
    var xOffsets = [CGFloat]()
    var yOffsets = [CGFloat]()
    var shrinkParam = CGFloat(10)
    
    //MARK:- UICollectionViewLayout functions
    override func prepare() {
    
         xOffsets = [CGFloat]()
        
        for column in 0..<numberOfColumns {
            xOffsets.append(cellPadding + (CGFloat(column) * itemSize.width))
        }
        let yPosition = (collectionView!.bounds.height / 2 ) - (itemSize.height / 2 )
        
        yOffsets = [CGFloat](repeating: yPosition, count: numberOfColumns)
        var zIndex = 0
        for section in 0..<collectionView!.numberOfSections {
            for item in 0..<collectionView!.numberOfItems(inSection: section) {
                let indexPath = NSIndexPath(item: item, section: section)

                let isFirstCellInCollection = indexPath.section == 0 && indexPath.row == 0
                var frame : CGRect?
                if isFirstCellInCollection {
                    frame = createFirstShrinkableCellRect()
                } else {
                    frame = createStackedCellRectFrom(indexPath)
                }
                let insetFrame = frame!.insetBy(dx: cellPadding, dy: cellPadding)
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                
                attr.frame = insetFrame
                attr.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0)
                attr.zIndex = zIndex
                zIndex += 1
                attributes.updateValue(attr, forKey: indexPath)
                
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for (_, value) in attributes {
            if value.frame.intersects(rect) {
                layoutAttributes.append(value)
            }
            
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let value = attributes[indexPath as NSIndexPath] {
            return value
        }
        return UICollectionViewLayoutAttributes()
    }

    
    override var collectionViewContentSize: CGSize {
        let contentWidth = (cellPadding + itemSize.width) * 6
        return CGSize(width: contentWidth, height: contentHeight)
    
    }
    
    //MARK:- Regular cells
    
    func createFirstCellRect() -> CGRect {
        let xOffset = collectionView!.contentOffset.x<=0 ? 0 : collectionView!.contentOffset.x
        let yPosition = (collectionView!.bounds.height / 2 ) - (itemSize.height / 2 )
        let origin = CGPoint(x: xOffset, y: yPosition)
        return CGRect(origin: origin, size: itemSize)
    }
    
    func createStackedCellRectFrom(_ indexPath : NSIndexPath) -> CGRect {
        var xOffset : CGFloat = CGFloat(0)
        if collectionView!.contentOffset.x<=0 {
            xOffset = xOffsets[indexPath.section]
        } else  {
            if collectionView!.contentOffset.x >= (xOffsets[indexPath.section] / 2){
                xOffset = collectionView!.contentOffset.x
            } else {
                xOffset = collectionView!.contentOffset.x - xOffsets[indexPath.section]
            }
        }
        
        let origin = CGPoint(x: abs(xOffset), y: yOffsets[indexPath.section])
        return CGRect(origin: origin, size: itemSize)
    }
    
    //MARK:- Shrinkable cells
    
    func createFirstShrinkableCellRect() -> CGRect {
        let xOffset = collectionView!.contentOffset.x<=0 ? 0 : collectionView!.contentOffset.x
        let yPosition = (collectionView!.bounds.height / 2 ) - (itemSize.height / 2 )
        let origin = CGPoint(x: xOffset, y: yPosition)
        var progress = CGFloat(0)
        
        
        var size = itemSize
        
        if collectionView!.contentOffset.x>0 {
            
            if collectionView!.contentOffset.x >= (xOffsets[0] / 2){
                
                progress = abs(collectionView!.contentOffset.x) / itemSize.width
                if (progress >= 4.0) {
                    progress = 4.0
                }
                
                size = CGSize(width: itemSize.width - (shrinkParam * progress), height: itemSize.height - (shrinkParam * progress))
                
            } else {
                
                progress = abs(collectionView!.contentOffset.x) / itemSize.width
                if (progress >= 4.0) {
                    progress = 4.0
                }
                size = CGSize(width: itemSize.width - (shrinkParam * progress), height: itemSize.height - (shrinkParam * progress))
            }
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    func createShrinkableStackedCellRectFrom(_ indexPath : NSIndexPath) -> CGRect {
        
        var xOffset = CGFloat(0)
        var progress = CGFloat(0)
        
        var yOffset = yOffsets[indexPath.section]
        var size = itemSize
        
        if collectionView!.contentOffset.x<=0 {
            xOffset = xOffsets[indexPath.section]
            yOffset = yOffsets[indexPath.section]
        } else  {
            if collectionView!.contentOffset.x >= (xOffsets[indexPath.section] / 2){
                xOffset = collectionView!.contentOffset.x
                
                progress = abs(collectionView!.contentOffset.x) / itemSize.width
                if (progress >= 4.0) {
                    progress = 4.0
                }
                
                size = CGSize(width: itemSize.width - (shrinkParam * progress), height: itemSize.height - (shrinkParam * progress))
                
                xOffset = collectionView!.contentOffset.x + (progress * CGFloat(indexPath.section))
                
                
            } else {
                xOffset = collectionView!.contentOffset.x - xOffsets[indexPath.section]
                progress = abs(collectionView!.contentOffset.x) / itemSize.width
                if (progress >= 4.0) {
                    progress = 4.0
                }
                size = CGSize(width: itemSize.width - (shrinkParam * progress), height: itemSize.height - (shrinkParam * progress))
                
                
            }
        }
        print("La sección es \(indexPath.section) contentOffset \(collectionView!.contentOffset.x) size \(size) & progress \(progress)")
        let origin = CGPoint(x: abs(xOffset), y: yOffset)
        return CGRect(origin: origin, size: size)
    }
    
    


}
