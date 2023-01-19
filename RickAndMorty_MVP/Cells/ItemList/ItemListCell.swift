//
//  ItemListCell.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class ItemListCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        container.layer.cornerRadius = 16
        container.backgroundColor = .orange
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 6
        
        self.imageBackground.superview?.layer.cornerRadius = 16
    }
    
    func loadEpisode(_ data: EpisodeModel) {
        self.imageBackground.image = UIImage(named: "episodios")
        self.photo.superview?.isHidden = true
        self.name.text = data.name
    }
    
    func loadCharacter(_ data: CharacterModel) {
        self.imageBackground.image = UIImage(named: "personajes")
        self.photo.superview?.isHidden = false
        if let urlImage = URL(string: data.image) {
            self.photo.load(url: urlImage)
        } else {
            self.photo.image = .init(named: "placeholder")
        }
        if let superview = self.photo.superview {
            superview.layer.cornerRadius = superview.frame.height / 2
        }
        self.photo.layer.cornerRadius = self.photo.frame.height / 2
        self.name.text = data.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
