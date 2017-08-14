//
//  AJMLayout.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 12/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class AJMLayout: UICollectionViewLayout {
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var numberOfColumns = 6
    private var cellPadding : CGFloat = 5
    private var contentHeight : CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.height - (insets.bottom + insets.top)
        }
    }
    private var contentWidth: CGFloat = 0.0
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = CGFloat(300)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 200, count: numberOfColumns)
            var zIndex = 0
            for section in 0..<collectionView!.numberOfSections {
                for item in 0..<collectionView!.numberOfItems(inSection: section) {
                    
                    let indexPath = NSIndexPath(item: item, section: section)
                    let width = columnWidth - (cellPadding * 2)
                    let height = 300 - (cellPadding * 2)
                    
                    let frame = CGRect(x: xOffsets[section], y: yOffsets[item], width: width, height: height)
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                    attributes.frame = insetFrame
                    attributes.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0)
                    attributes.zIndex = zIndex
                    zIndex += 1
                    cache.append(attributes)
                    
                }
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
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    

}
