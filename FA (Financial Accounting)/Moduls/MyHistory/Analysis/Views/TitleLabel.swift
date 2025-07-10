//
//  TitleLabel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.07.2025.
//
import UIKit

final class TitleLabel: UILabel {
    //MARK: - Constants
    private enum Constants {
        static let text: String = "Анализ"
        static let font: UIFont = .systemFont(ofSize: 32, weight: .bold)
    }
    //MARK: - LyfeCycle
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    private func configure() {
        backgroundColor = .clear
        text = Constants.text
        font = Constants.font
    }
}

#Preview {
    TitleLabel()
}
