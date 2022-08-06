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
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigation()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        getCoins()
    }
    
    private func setupNavigation() {
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.indent"), style: .plain, target: self, action: #selector(presentModalController))
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func getCoins() {
        DataFetcherService.sharedInstance.fetchCoins { [weak self] coinsModel in
            guard let coinsModel = coinsModel,
                  let self = self else { return }
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
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = .systemGray6
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func presentModalController() {
        
        let modalViewController = ModalViewController()
        modalViewController.delegate = self
        let nav = UINavigationController(rootViewController: modalViewController)
        nav.modalPresentationStyle = .pageSheet
        
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.symbol = coins[indexPath.row].symbol
        
        present(detailVC, animated: true)
        
       // navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension CoinsViewController: SortViewControllerDelegate {
    
    func sortBy(option: SortBy) {
        switch option {
        case .fallingInAnHour:
            coins = coins.sorted(by: { $0.metrics.market_data.percent_change_usd_last_1_hour ?? 0 > $1.metrics.market_data.percent_change_usd_last_1_hour ?? 0
            })
        case .growthInAnHour:
            coins = coins.sorted(by: { $0.metrics.market_data.percent_change_usd_last_1_hour ?? 0 < $1.metrics.market_data.percent_change_usd_last_1_hour ?? 0
            })
        case .fallingPerDay:
            coins = coins.sorted(by: { $0.metrics.market_data.percent_change_usd_last_24_hours ?? 0 > $1.metrics.market_data.percent_change_usd_last_24_hours ?? 0
            })
        case .growthPerDay:
            coins = coins.sorted(by: { $0.metrics.market_data.percent_change_usd_last_24_hours ?? 0 < $1.metrics.market_data.percent_change_usd_last_24_hours ?? 0
            })
        }
        
        tableView.reloadData()
    }
    
   
}

