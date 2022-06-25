//
//  UITableViewExtension.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit

extension UITableViewCell {
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    static var identifier: String { String(describing: self) }
}
