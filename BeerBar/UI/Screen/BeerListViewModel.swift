//
//  BeerListViewModel.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

typealias BeerListRequest = ([Beer]) -> ()

protocol BeerListViewModelInterface {
    func getInitialBeer(completionBlock: @escaping BeerListRequest)
    func getNextPage(completionBlock: @escaping BeerListRequest)
}

final class BeerListViewModel: BeerListViewModelInterface {
    private let networkManager: NetworkManagerInterface
    
    private let currentPage: Int = 0
    
    init(networkManager: NetworkManagerInterface) {
        self.networkManager = networkManager
    }

    func getInitialBeer(completionBlock: @escaping BeerListRequest) {
        networkManager.getBeer(count: 20, page: 0) { response in
            guard let response = response else {
                completionBlock([])
                return
            }
            let beers = response.map { Beer($0) }
            
            completionBlock(beers)
        }
    }
    
    func getNextPage(completionBlock: @escaping BeerListRequest) {
        
    }
}
