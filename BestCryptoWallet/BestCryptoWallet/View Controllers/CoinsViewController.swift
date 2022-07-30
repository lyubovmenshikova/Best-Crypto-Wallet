//
//  CoinsViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 29.07.2022.
//

import UIKit

class CoinsViewController: UIViewController {
    
    var coins: [Items]!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinsTableViewCell.self, forCellReuseIdentifier: "CoinsTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        getCoins()
    }
    
    private func getCoins() {
        DataFetcherService.sharedInstance.fetchCoins { coinsModel in
            guard let coinsModel = coinsModel else { return }
            self.coins = coinsModel.data
            self.tableView.reloadData()
        }
    }

}

extension CoinsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinsTableViewCell", for: indexPath) as! CoinsTableViewCell
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
