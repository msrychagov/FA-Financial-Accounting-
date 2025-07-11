//
//  TransactionCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//
import UIKit

final class CategoryTableViewCell: UITableViewCell {
    private let categoryView: UIView = UIView()
    private let numbsView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let emojiLabel: UILabel = UILabel()
    private let circleView: UIView = UIView()
    private let sumLabel: UILabel = UILabel()
    private let percentLabel: UILabel = UILabel()
    
    static let reuseIdentifier: String = "CategoryTableViewCell"
    
    func configure(category: Category, sum: String, percent: String) {
        configureCategoryView()
        configureCircleView()
        configureEmojiLabel(emoji: category.emoji)
        configureNameLabel(name: category.name)
        configureNumbsView()
        configurePercentLabel(percent: percent)
        configureSumLabel(sum: sum)
    }
    
    private func configureCategoryView() {
        contentView.addSubview(categoryView)
        categoryView.pinLeft(to: contentView.leadingAnchor, 16)
        categoryView.pinVertical(to: contentView)
    }
    
    private func configureNumbsView() {
        numbsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(numbsView)
        numbsView.pinLeft(to: categoryView.trailingAnchor)
        numbsView.pinRight(to: contentView.trailingAnchor, 16)
        numbsView.pinVertical(to: contentView, 8)
    }
    
    private func configureEmojiLabel(emoji: String) {
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 14, weight: .bold)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(emojiLabel)
        emojiLabel.pinCenter(to: circleView)
    }
    
    private func configureCircleView() {
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .accent.withAlphaComponent(0.2)
        circleView.layer.cornerRadius = 11
        categoryView.addSubview(circleView)
        circleView.setWidth(22)
        circleView.setHeight(22)
        circleView.pinLeft(to: categoryView.leadingAnchor)
        circleView.pinCenterY(to: categoryView)
    }
    
    private func configureNameLabel(name: String) {
        nameLabel.text = name
        nameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        categoryView.addSubview(nameLabel)
        nameLabel.pinLeft(to: circleView.trailingAnchor, 12)
        nameLabel.pinVertical(to: categoryView)
    }
    
    private func configureSumLabel(sum: String) {
        sumLabel.text = sum
        sumLabel.font = .systemFont(ofSize: 17, weight: .regular)
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        numbsView.addSubview(sumLabel)
        sumLabel.pinHorizontal(to: numbsView)
        sumLabel.pinTop(to: percentLabel.bottomAnchor)
        sumLabel.pinBottom(to: numbsView.bottomAnchor)
        
    }
    private func configurePercentLabel(percent: String) {
        percentLabel.text = percent
        percentLabel.font = .systemFont(ofSize: 17, weight: .regular)
        percentLabel.textAlignment = .right
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        numbsView.addSubview(percentLabel)
        percentLabel.pinHorizontal(to: numbsView)
        percentLabel.pinTop(to: numbsView.topAnchor)
    }
}
