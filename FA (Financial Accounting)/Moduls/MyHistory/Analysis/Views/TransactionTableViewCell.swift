//
//  TransactionCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//
import UIKit

final class TransactionTableViewCell: UITableViewCell {
    private let transactionView: UIView = UIView()
    private let numbsView: UIView = UIView()
    private let textView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let commentLabel: UILabel = UILabel()
    private let emojiLabel: UILabel = UILabel()
    private let circleView: UIView = UIView()
    private let sumLabel: UILabel = UILabel()
    private let percentLabel: UILabel = UILabel()
    
    static let reuseIdentifier: String = "TransactionTableViewCell"
    
    func configure(transaction: Transaction, sum: String, percent: String) {
        configureTransactionView()
        configureCircleView()
        configureTextView()
        configureEmojiLabel(emoji: transaction.category.emoji)
        configureNameLabel(name: transaction.category.name)
        configureCommentLabel(comment: transaction.comment)
        configureNumbsView()
        configurePercentLabel(percent: percent)
        configureSumLabel(sum: sum)
    }
    
    private func configureTransactionView() {
        contentView.addSubview(transactionView)
        transactionView.pinLeft(to: contentView.leadingAnchor, 16)
        transactionView.pinVertical(to: contentView)
    }
    
    private func configureTextView() {
        contentView.addSubview(textView)
        textView.pinLeft(to: circleView.trailingAnchor)
        textView.pinVertical(to: contentView)
    }
    
    private func configureNumbsView() {
        numbsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(numbsView)
        numbsView.pinLeft(to: transactionView.trailingAnchor)
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
        transactionView.addSubview(circleView)
        circleView.setWidth(22)
        circleView.setHeight(22)
        circleView.pinLeft(to: transactionView.leadingAnchor)
        circleView.pinCenterY(to: transactionView)
    }
    
    private func configureNameLabel(name: String) {
        nameLabel.text = name
        nameLabel.font = .systemFont(ofSize: 17, weight: .regular)
        textView.addSubview(nameLabel)
        nameLabel.pinLeft(to: textView.leadingAnchor, 12)
        nameLabel.pinTop(to: textView.topAnchor, 8)
    }
    
    private func configureCommentLabel(comment: String) {
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = comment
        commentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        commentLabel.tintColor = .systemGroupedBackground
        commentLabel.numberOfLines = 0
        textView.addSubview(commentLabel)
        commentLabel.pinLeft(to: textView.leadingAnchor, 12)
        commentLabel.pinTop(to: nameLabel.bottomAnchor)
        commentLabel.pinBottom(to: textView.bottomAnchor, 8)
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
