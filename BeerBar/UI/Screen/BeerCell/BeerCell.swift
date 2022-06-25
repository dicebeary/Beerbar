//
//  BeerCell.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit
import Kingfisher

final class BeerCell: UITableViewCell {

    @IBOutlet private weak var beerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var taglineLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 0

        taglineLabel.font = .systemFont(ofSize: 16, weight: .regular)
        taglineLabel.numberOfLines = 0

        descriptionLabel.font = .systemFont(ofSize: 14, weight: .light)
        descriptionLabel.numberOfLines = 0
    }
    
    func configureCell(_ beer: Beer) {
        nameLabel.text = beer.name
        taglineLabel.text = beer.tagline
        descriptionLabel.text = beer.description
        beerImageView.kf.setImage(with: URL(string: beer.imageUrl))
    }    
}
