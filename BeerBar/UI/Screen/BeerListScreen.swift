//
//  BeerListScreen.swift
//  BeerBar
//
//  Created by Vajda Kristóf on 2022. 06. 25..
//

import UIKit
import Resolver

final class BeerListScreen: UIViewController {
    @Injected var viewModel: BeerListViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    private var beers: [Beer] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.register(BeerCell.nib, forCellReuseIdentifier: "BeerCell")
        tableView.dataSource = self
        
        viewModel.getInitialBeer { [weak self] beers in
            debugPrint(beers)
            self?.beers = beers
        }
    }
}

// MARK: UITableViewDataSource Delegate

extension BeerListScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { beers.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as? BeerCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(beers[indexPath.row])
        
        return cell
    }
}
