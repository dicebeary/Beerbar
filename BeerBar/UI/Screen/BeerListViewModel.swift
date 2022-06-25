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
    
    private var currentPage: Int = 1
    private let pageSize = 20
    
    init(networkManager: NetworkManagerInterface) {
        self.networkManager = networkManager
    }

    func getInitialBeer(completionBlock: @escaping BeerListRequest) {
        networkManager.getBeer(count: pageSize, page: 1) { [weak self] response in
            guard let response = response else {
                completionBlock([])
                return
            }
            let beers = response.map { Beer($0) }

            self?.currentPage = 1
            completionBlock(beers)
        }
    }
    
    func getNextPage(completionBlock: @escaping BeerListRequest) {
        let nextPage = currentPage + 1
        networkManager.getBeer(count: pageSize, page: nextPage) { [weak self] response in
            guard let response = response else {
                // TODO: Handle error
                completionBlock([])
                return
            }
            let beers = response.map { Beer($0) }
            
            self?.currentPage = nextPage
            completionBlock(beers)
        }
    }
}
