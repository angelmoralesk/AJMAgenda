//
//  AgendaLayout.swift
//  AJMAgenda
//
//  Created by Angel Jesse Morales Karam Kairuz on 24/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

struct HourCell {
    static let Width : CGFloat = 100
}

struct DayHeaderCell {
    static let Height : CGFloat = 40
}

struct Result  {
    let indexPath : IndexPath
    let cellFrame : CGRect
}

class AgendaLayout: UICollectionViewLayout {
    
    var attributes : [UICollectionViewLayoutAttributes] = []
    var daySize : CGSize = CGSize.zero
    let daysPerWeek = 5

    
    override func prepare() {
        
        let height = (collectionView!.bounds.height - DayHeaderCell.Height) / CGFloat(daysPerWeek)
        let width = (collectionView!.bounds.width - HourCell.Width) / CGFloat(daysPerWeek)
        daySize = CGSize(width: width, height: height)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       
        var attributes : [UICollectionViewLayoutAttributes] = []
        
        // get the attributes of cells
        let result = fetchIndexPathsAndFramesForCellsInRect(rect)
        for aResult in result {
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: aResult.indexPath)
            attribute.frame = aResult.cellFrame
            attributes.append(attribute)
            
        }
        
        // get the attributes of supplementary views
        
        return attributes
        
    }
    
    func fetchIndexPathsAndFramesForCellsInRect(_ rect : CGRect) -> [Result] {
        var result : [Result] = []
        var dayCounter = 0
        for i in 0..<daysPerWeek  {
            for j in 0..<daysPerWeek {
                let posX = collectionView!.bounds.width - HourCell.Width - ( CGFloat(j) * daySize.width)
                let posY = collectionView!.bounds.height - DayHeaderCell.Height - ( CGFloat(i) * daySize.height)
                let cellFrame = CGRect(x: posX, y: posY, width: daySize.width, height: daySize.height)
               // print(cellFrame.origin)
                if rect.contains(cellFrame.origin) {
                    let indexPath = IndexPath(row: dayCounter, section: 0)
                    let aResult = Result(indexPath: indexPath, cellFrame: cellFrame)
                    result.append(aResult)
               }
                dayCounter += 1
            }
        }
        return result
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        let width = 2 * HourCell.Width + daySize.width * CGFloat(daysPerWeek)
        let height = 2 * DayHeaderCell.Height + CGFloat(daySize.height) * CGFloat(daysPerWeek)
        print(CGSize(width: width, height: height))
        return CGSize(width: width, height: height)
        
        
    }
}
