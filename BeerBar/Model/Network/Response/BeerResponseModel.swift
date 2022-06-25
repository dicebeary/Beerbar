//
//  BeerResponseModel.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import Foundation

struct BeerResponseModel: Codable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case description
        case imageUrl = "image_url"
    }
}
