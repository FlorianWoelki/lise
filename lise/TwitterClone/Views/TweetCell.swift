//
//  TweetCell.swift
//  lise
//
//  Created by Florian Woelki on 09.05.19.
//  Copyright © 2019 Florian Woelki. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
