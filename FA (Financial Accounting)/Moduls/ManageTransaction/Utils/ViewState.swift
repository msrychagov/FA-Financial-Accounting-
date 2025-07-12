//
//  ViewState.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

enum ViewState {
    case idle
    case loading
    case errorSaving
    case success
    case error(String)
}
