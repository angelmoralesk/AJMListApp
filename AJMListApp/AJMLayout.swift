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
            }
            contentWidth = CGFloat(collectionView!.numberOfSections) * columnWidth
            
        }
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
