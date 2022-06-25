//
//  BeerListScreen.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit
import Resolver

final class BeerListScreen: UIViewController {
    @Injected private var viewModel: BeerListViewModel
    
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private var allPageLoaded = false
    private var beers: [Beer] = [] {
        didSet {
            debugPrint(beers.count)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        setupTableView()
        setupRefreshControl()
        
        viewModel.getInitialBeer { [weak self] beers in
            self?.beers = beers
        }
    }
}

// MARK: Setup TableView

extension BeerListScreen {
    func setupTableView() {
        tableView.register(BeerCell.nib, forCellReuseIdentifier: BeerCell.identifier)
        tableView.register(LoadingCell.nib, forCellReuseIdentifier: LoadingCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: Setup RefreshControl

extension BeerListScreen {
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh(_ sender: AnyObject) {
        viewModel.getInitialBeer { [weak self] beers in
            self?.beers = beers
            self?.refreshControl.endRefreshing()
        }
    }
}

// MARK: UITableViewDataSource Delegate

extension BeerListScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPageLoaded ? beers.count : beers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if beers.count > indexPath.row {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier, for: indexPath) as? BeerCell else {
                return UITableViewCell()
            }

            cell.configureCell(beers[indexPath.row])
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            cell.startAnimating()
            return cell
        }
    }
}

extension BeerListScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is LoadingCell, indexPath.row != 0 {
            viewModel.getNextPage { [weak self] nextBeers in
                if nextBeers.count == 0 {
                    self?.allPageLoaded = true
                }
                
                self?.beers += nextBeers
            }
        }
    }
}
