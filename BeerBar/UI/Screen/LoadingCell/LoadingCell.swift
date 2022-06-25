//
//  LoadingCell.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    func startAnimating() {
        loadingIndicatorView.startAnimating()
    }
}
