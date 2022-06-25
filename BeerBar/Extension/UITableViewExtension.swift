//
//  UITableViewExtension.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
