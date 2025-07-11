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
        let up  = UIAction(title: "По возрастанию",  image: UIImage(systemName: "chevron.up"))           { _ in
            self.sortButton.setTitle("По возрастанию", for: .normal)
            self.menuDelegate?.menu(.ascending)
        }
        let down = UIAction(title: "По убыванию",   image: UIImage(systemName: "chevron.down"))          { _ in
            self.sortButton.setTitle("По убыванию", for: .normal)
            self.menuDelegate?.menu(.descending)
        }
        return UIMenu(children: [up, down])
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
        sortButton.setTitle("По возрастанию", for: .normal)
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
    case ascending
    case descending
}
