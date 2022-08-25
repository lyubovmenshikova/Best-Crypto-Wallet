//
//  CoinsViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 29.07.2022.
//

import UIKit
import Combine

class CoinsViewController: UIViewController {
    
    var coins: [Items]!
    var viewModel: CoinsViewModel? {
        didSet {
            viewModel?.getCoinsModel {
                self.tableView.reloadData()
            }
        }
    }
    private var cancellables: Set<AnyCancellable> = []
    
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
        setupBinders()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupNavigation() {
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.indent"), style: .plain, target: self, action: #selector(presentModalController))
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .black
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
    
    
    private func setupBinders() {
        guard let viewModel = viewModel else { return }
        viewModel.$coins.sink(receiveValue: { [weak self] coins in
            guard let self = self else { return }
            if let coins = coins {
                self.coins = coins
            }
        }).store(in: &cancellables)
        viewModel.$result.sink { [weak self] result in
            guard let self = self,
                  let result = result else { return }
            if result {
                print("succes")
            } else {
                self.showAlert(title: "Что то пошло не так")
            }
        }.store(in: &cancellables)
    }
    
    private func showAlert(title: String) {
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil)
        alertController.addAction(closeAction)
        present(alertController, animated: true, completion: nil)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let symbol = coins[indexPath.row].symbol ?? ""
        let detailVC = DetailsViewControllerBuilder.build(symbol: symbol)
        
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        header.backgroundColor = UIColor(red: 53/255, green: 212/255, blue: 184/255, alpha: 0.95)

        let priceLabel = UILabel(frame: CGRect(x: 95, y: 5, width: 80, height: header.frame.size.height - 10))
        priceLabel.text = "Цена"
        priceLabel.textAlignment = .right

        let changeOneHourLabel = UILabel(frame: CGRect(x: 30 + priceLabel.frame.maxX, y: 5, width: 80, height: header.frame.size.height - 10))
        changeOneHourLabel.font = UIFont(name: "Arial", size: 15)
        changeOneHourLabel.text = "Изменения за час"
        changeOneHourLabel.numberOfLines = 0
        changeOneHourLabel.textAlignment = .center

        let changeDayLabel = UILabel(frame: CGRect(x: 15 + changeOneHourLabel.frame.maxX, y: 5, width: 60, height: header.frame.size.height - 10))
        changeDayLabel.font = UIFont(name: "Arial", size: 15)
        changeDayLabel.text = "За сутки"
        changeDayLabel.numberOfLines = 0
        changeDayLabel.textAlignment = .center

        header.addSubview(priceLabel)
        header.addSubview(changeOneHourLabel)
        header.addSubview(changeDayLabel)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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

