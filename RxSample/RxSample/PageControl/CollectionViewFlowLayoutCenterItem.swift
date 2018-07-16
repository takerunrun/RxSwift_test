//
//  CollectionViewFlowLayoutCenterItem.swift
//  RxSample
//
//  Created by admin on 2018/07/09.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class CollectionViewFlowLayoutCenterItem: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if let cv = self.collectionView {
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5
            print(halfWidth)
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                var candidateAttributes: UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    if let candAttrs = candidateAttributes {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes
                        }
                    } else {
                        candidateAttributes = attributes
                        continue
                    }
                }
                
                return CGPoint(x: round((candidateAttributes?.center.x)! - halfWidth), y: proposedContentOffset.y)
            }
        }
        
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
