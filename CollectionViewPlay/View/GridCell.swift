//
//  GridCell.swift
//  CollectionViewPlay
//
//  Created by vinmac on 16/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import Foundation
import UIKit

class GridCell: UICollectionViewCell {
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var lblItemName: UILabel!
    
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setGridSize(size: CGFloat) {
        self.widthConstraint.constant = size
        self.heightConstraint.constant = size
    }
}
