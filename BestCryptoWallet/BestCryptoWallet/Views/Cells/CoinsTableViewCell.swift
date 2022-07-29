//
//  CoinsTableViewCell.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 29.07.2022.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {
    
    static let identifier = "CoinsTableViewCell"
    
    let coinNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coinNumberLabel)
        contentView.addSubview(coinNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coinNumberLabel.frame = CGRect(x: 5,
                                       y: 5,
                                       width: 25,
                                       height: contentView.frame.size.height - 10)
        coinNameLabel.frame = CGRect(x: 5 + coinNumberLabel.frame.size.width,
                                     y: 5,
                                     width: 90,
                                     height: contentView.frame.size.height - 10)
    }
    
    func configure(with coinsModel: Items) {
        DispatchQueue.main.async {
            self.coinNameLabel.text = coinsModel.name
        }
    }
    

}
