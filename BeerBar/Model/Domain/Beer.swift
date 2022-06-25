//
//  Beer.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import Foundation

struct Beer {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageUrl: String

    init(_ beerApiModel: BeerResponseModel) {
        self.id = beerApiModel.id
        self.name = beerApiModel.name
        self.tagline = beerApiModel.tagline
        self.description = beerApiModel.description
        self.imageUrl = beerApiModel.imageUrl ?? ""
    }
}
