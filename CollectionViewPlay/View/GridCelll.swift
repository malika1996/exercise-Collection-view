//
//  GridCelll.swift
//  CollectionViewPlay
//
//  Created by vinmac on 16/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class GridCelll: UICollectionViewCell {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.setGridSize(size: 100)
        
    }
    
    func setGridSize(size: CGFloat) {
        self.widthConstraint.constant = size
        self.heightConstraint.constant = size
    }

}
