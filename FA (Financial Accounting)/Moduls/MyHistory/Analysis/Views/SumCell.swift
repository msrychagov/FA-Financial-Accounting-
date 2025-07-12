//
//  SumCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

import UIKit

final class SumCell: UITableViewCell {
    private let nameLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()
    
    static let reuseIdentifier = "SumCell"
    func configure(sum: String) {
        valueLabel.text = sum
        configureNameLabel()
        configureValueLabel()
    }
    
    private func configureNameLabel() {
        nameLabel.text = "Сумма"
        nameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        nameLabel.pinLeft(to: contentView.leadingAnchor, 16)
        nameLabel.pinCenterY(to: contentView)
    }
    
    private func configureValueLabel() {
        valueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(valueLabel)
        valueLabel.pinLeft(to: nameLabel.trailingAnchor)
        valueLabel.pinRight(to: contentView.trailingAnchor, 16)
        valueLabel.pinVertical(to: contentView)
    }
}
