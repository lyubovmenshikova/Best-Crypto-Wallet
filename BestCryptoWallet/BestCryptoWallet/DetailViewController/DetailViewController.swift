//
//  DetailViewController.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 03.08.2022.
//

import UIKit
import Combine

final class DetailViewController: BackgroundViewController {
    
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
        label.font = UIFont(name: "Damascus", size: 17)
        return label
    }()
    
    var resourceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Damascus", size: 17)
        label.isUserInteractionEnabled = true
        label.textColor = .blue
        return label
    }()
    
    var viewModel: DetailViewModel?
    private var observer: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.addSubview(nameLabel)
        view.addSubview(taglineLabel)
        view.addSubview(iconImage)
        view.addSubview(resourceLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveOnURL))
        resourceLabel.addGestureRecognizer(tapGesture)
        
        setupBinders()
        viewModel?.getCoinModel()
        setupConstraints()
    }
    
    private func setupBinders() {
        guard let viewModel = viewModel else { return }
        observer = viewModel.$oneCoinModel.sink(receiveValue: { [weak self] oneCoinModel in
            guard let self = self else { return }
            self.nameLabel.text = oneCoinModel?.data.name ?? "Нет информации"
            self.taglineLabel.text = oneCoinModel?.data.tagline ?? "Нет слогана"
            self.resourceLabel.text = oneCoinModel?.data.relevant_resources?[0].url ?? "Нет ссылки"
        })
    }
    
    @objc func moveOnURL() {
        UIApplication.shared.open(URL(string: resourceLabel.text ?? "")! as URL, options: [:], completionHandler: nil  )
    }
    
    private func setupConstraints() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        resourceLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            taglineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resourceLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 10),
            resourceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resourceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resourceLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}
