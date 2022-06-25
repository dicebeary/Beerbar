//
//  NetworkManager.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2021. 10. 02..
//

import Alamofire

final class NetworkManager: NetworkManagerInterface {
    private let session: Session

    init(session: Session) {
        self.session = session
    }
    
    func getBeer(count: Int,
                 page: Int,
                 completionBlock: @escaping BeersRequest) {
        session.request(Constants.api + "/beers")
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [BeerResponseModel].self) { response in
                switch response.result {
                case .success(let responseModel):
                    completionBlock(responseModel)
                case .failure:
                    completionBlock(nil)
                }
        }
    }
}
