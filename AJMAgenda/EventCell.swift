//
//  EventCell.swift
//  AJMAgenda
//
//  Created by Angel Jesse Morales Karam Kairuz on 24/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var title : String! {
        didSet {
            titleLabel.text = title
        }
    }
}
