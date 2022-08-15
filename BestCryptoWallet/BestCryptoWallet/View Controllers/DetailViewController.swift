//
//  DetailViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 03.08.2022.
//

import UIKit

class DetailViewController: BackgroundViewController {
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin1")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Damascus", size: 20)
        return label
    }()
    
    var taglineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Damascus", size: 18)
        return label
    }()
    
    var symbol: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameLabel)
        view.addSubview(taglineLabel)
        view.addSubview(iconImage)
        
        getInfo()
        setupConstraints()
    }
    
    private func getInfo() {
        if let symbol = symbol {
            DataFetcherService.sharedInstance.fetchOneCoin(symbol: symbol) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let oneCoin):
                    self.nameLabel.text = oneCoin?.data.name ?? "No name"
                    self.taglineLabel.text = oneCoin?.data.tagline ?? "Нет слогана"
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setupConstraints() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            iconImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            iconImage.heightAnchor.constraint(equalToConstant: 120),
            nameLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            taglineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            taglineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            taglineLabel.heightAnchor.constraint(equalToConstant: 50),
            taglineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30)
        ])
    }

}
