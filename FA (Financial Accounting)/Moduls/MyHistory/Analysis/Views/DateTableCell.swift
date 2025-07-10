//
//  DateTableCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//
import UIKit
import SwiftUI

final class DateTableCell: UITableViewCell {
    private let label: UILabel = UILabel()
    private let picker: UIDatePicker = UIDatePicker()
    private(set) var border: Border?
    var dateDelegate: DateDelegate?
    
    static let reuseIdentifier = "DateTableCell"
    func configure(border: Border) {
        self.border = border
        configureLabel(text: border == .start ? " Период: начало" : "Период: конец")
        configurePicker(date: border == .start ? startHistory : generalEnd)
    }
    
    private func configureLabel(text: String) {
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .regular)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.pinLeft(to: contentView.leadingAnchor, 16)
        label.pinVertical(to: contentView)
        
    }
    
    private func configurePicker(date: Date) {
        picker.date = date
        picker.datePickerMode = .date
        picker.tintColor = .accent
        picker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        contentView.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.pinRight(to: contentView.trailingAnchor, 16)
        picker.pinVertical(to: contentView, 5)
        picker.pinLeft(to: label.trailingAnchor)
    }
    
    func setDate(_ date: Date) {
        picker.date = date
    }
    
    func getDate() -> Date {
        return picker.date
    }
    
    @objc func dateDidChange(_ sender: DateTableCell) {
        dateDelegate?.datePicker(cell: self, newDate: picker.date)
    }
    
    
}

protocol DateDelegate: AnyObject {
    func datePicker(cell: DateTableCell, newDate: Date)
}

#Preview {
    let cell = DateTableCell()
    cell.configure(border: .start)
    cell.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
    return cell
}
