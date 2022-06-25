//
//  NetworkManagerInterface.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2021. 10. 02..
//

typealias BeersRequest = ([BeerResponseModel]?) -> ()

protocol NetworkManagerInterface {
    func getBeer(count: Int,
                 page: Int,
                 completionBlock: @escaping BeersRequest)
}
