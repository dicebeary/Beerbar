//
//  Resolver.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2021. 10. 03..
//

import Alamofire
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerManager()
        registerUI()
    }
}

// MARK: - Core registrations
extension Resolver {
    static func registerManager() {
        register { _ -> NetworkManagerInterface in
            NetworkManager(session: AF)
        }
        .scope(.application)
    }
}

// MARK: - UI registrations
extension Resolver {
    static func registerUI() {
        register { resolver in
            BeerListViewModel(networkManager: resolver.resolve(NetworkManagerInterface.self))
        }.implements(BeerListViewModelInterface.self)
    }
}
