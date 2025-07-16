//
//  SortCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//
import UIKit

final class SortCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let sortButton: UIButton = UIButton(type: .system)
    private var menu: UIMenu {
        let date  = UIAction(title: "По дате")           { _ in
            self.sortButton.setTitle("По дате", for: .normal)
            self.menuDelegate?.menu(.date)
        }
        let sum = UIAction(title: "По сумме")          { _ in
            self.sortButton.setTitle("По сумме", for: .normal)
            self.menuDelegate?.menu(.sum)
        }
        return UIMenu(children: [date, sum])
    }
    
    var menuDelegate: MenuDelegate?
    
    static let reuseIdentifier = "SortCell"
    func configure() {
        configureTitleLabel()
        configureButton()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Сортировка"
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        contentView.addSubview(titleLabel)
        titleLabel.pinLeft(to: contentView.leadingAnchor, 16)
        titleLabel.pinVertical(to: contentView)
    }
    
    private func configureButton() {
        sortButton.menu = menu
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.setTitle("По дате", for: .normal)
        sortButton.setTitleColor(.secondAccent, for: .normal)
        sortButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        sortButton.backgroundColor = .clear
        contentView.addSubview(sortButton)
        sortButton.pinLeft(to: titleLabel.trailingAnchor, 8)
        sortButton.pinRight(to: contentView.trailingAnchor, 16)
        sortButton.pinVertical(to: contentView)
    }
    
    
}

protocol MenuDelegate: AnyObject {
    func menu(_ sortingType: SortingType)
}

enum SortingType {
    case date
    case sum
}
