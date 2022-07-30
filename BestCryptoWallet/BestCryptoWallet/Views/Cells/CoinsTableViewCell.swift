//
//  CoinsTableViewCell.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 29.07.2022.
//

import UIKit

class CoinsTableViewCell: UITableViewCell {
    
    static let identifier = "CoinsTableViewCell"
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let percentChangeOneHourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let percentChange24HoursLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coinNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentChangeOneHourLabel)
        contentView.addSubview(percentChange24HoursLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coinNameLabel.frame = CGRect(x: 10,
                                     y: 5,
                                     width: 75,
                                     height: contentView.frame.size.height - 10)
        priceLabel.frame = CGRect(x: 20 + coinNameLabel.frame.size.width,
                                  y: 5,
                                  width: 100,
                                  height: contentView.frame.size.height - 10)
        percentChangeOneHourLabel.frame = CGRect(x: 20 + priceLabel.frame.maxX ,
                                                 y: 5,
                                                 width: 60,
                                                 height: contentView.frame.size.height - 10)
        percentChange24HoursLabel.frame = CGRect(x: 20 + percentChangeOneHourLabel.frame.maxX,
                                                 y: 5,
                                                 width: 60,
                                                 height: contentView.frame.size.height - 10)
    }
    
    func configure(with coinsModel: Items) {
        DispatchQueue.main.async {
            self.coinNameLabel.text = coinsModel.name
            self.roundedDouble(with: coinsModel)
            self.percentChangeOneHourLabel.text = String(format: "%.2f", coinsModel.metrics.market_data.percent_change_usd_last_1_hour ?? 0.00) + "%"
            self.percentChange24HoursLabel.text = String(format: "%.2f", coinsModel.metrics.market_data.percent_change_usd_last_24_hours ?? 0.00) + "%"
        }
    }
    
    private func roundedDouble(with coinModel: Items) {
        if let marketData = Market(marketData: coinModel.metrics.market_data) {
            priceLabel.text = marketData.priceString + "$"
        }
    }
    

}
