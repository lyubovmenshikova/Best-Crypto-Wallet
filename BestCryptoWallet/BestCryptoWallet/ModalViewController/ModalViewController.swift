//
//  ModalViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 02.08.2022.
//

import UIKit

protocol SortViewControllerDelegate: AnyObject {
    func sortBy(option: SortBy)
}

final class ModalViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SortViewCell.self, forCellReuseIdentifier: SortViewCell.identifier)
        return tableView
    }()

    weak var delegate: SortViewControllerDelegate?
    var viewModel: ModalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Сортировать по:"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: TableViewDelegate, TableViewDataSource
extension ModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortViewCell.identifier, for: indexPath)
        if let sortOption = SortBy(index: indexPath.row) {
            cell.textLabel?.text = sortOption.description
        
            if UserDefaults.standard.object(forKey: "selectedIndex") != nil {
                let selectedIndex = UserDefaults.standard.integer(forKey: "selectedIndex")
                if sortOption == SortBy(rawValue: selectedIndex) {
                    cell.accessoryType = .checkmark
                }
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // check current cell
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        if let sortOption = SortBy(index: indexPath.row) {
            delegate?.sortBy(option: sortOption)
        }

        UserDefaults.standard.set(indexPath.row, forKey: "selectedIndex")
        
        dismiss(animated: true)
    }
    
    
}
