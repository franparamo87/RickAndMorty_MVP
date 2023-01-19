//
//  ItemMainListCell.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class ItemMainListCell: UICollectionViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        container.layer.cornerRadius = 16
        container.backgroundColor = .orange
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 6
        
        self.image.superview?.layer.cornerRadius = 16
    }
    
    func configure(_ data: ItemMainListModel) {
        self.image.image = data.image
        self.image.alpha = 0.6
        self.label.text = data.label
    }

}
