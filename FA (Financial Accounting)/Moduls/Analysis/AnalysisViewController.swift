//
//  AnalysisView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.07.2025.
//
import UIKit
import SwiftUI
import PieChart

final class AnalysisViewController: UIViewController {
    //MARK: - Variables
    private let vm: AnalysisViewModel
    private let dateAndSumSection: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private let actionMenuButton: UIButton = UIButton()
    private var loadingHost: UIHostingController<AnyView>?
    private var pieChart: PieChartView = PieChartView()
    
    
    
    //MARK: - Lyfecycle
    init(startDate: Date, endDate: Date, direction: Direction, service: TransactionsService = ServiceFactory.shared.createTransactionsService()) {
        vm = AnalysisViewModel(service: service, direction: direction)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showSwiftUILoading()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task { @MainActor in
            do {
                try await vm.loadData(startDate: Date.startBorder, endDate: Date.endBorder)
                vm.sort(by: .date)
                dateAndSumSection.reloadData()
                pieChart.animateTransition(to: vm.entities)
            } catch {
                hideSwiftUILoading()
                let alert = UIAlertController(
                    title: "Ошибка загрузки",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            hideSwiftUILoading()
        }
    }
    
    // MARK: — UIHostingController с ProgressView
    private func showSwiftUILoading() {
        let spinner = ProgressView("Загрузка данных")
            .frame(maxWidth: .infinity, alignment: .center)
            .progressViewStyle(CircularProgressViewStyle())
        
        let anyView = AnyView(
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                spinner
            }
        )
        
        let host = UIHostingController(rootView: anyView)
        addChild(host)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        host.didMove(toParent: self)
        loadingHost = host
    }
    
    private func hideSwiftUILoading() {
        guard let host = loadingHost else { return }
        host.willMove(toParent: nil)
        host.view.removeFromSuperview()
        host.removeFromParent()
        loadingHost = nil
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        configurePieChart()
        configureDateAndSumSection()
    }
    
    private func configurePieChart() {
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pieChart)
        pieChart.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 8)
        pieChart.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 8)
        pieChart.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        pieChart.setHeight(250)
    }
    
    private func configureDateAndSumSection() {
        dateAndSumSection.register(DateTableCell.self, forCellReuseIdentifier: DateTableCell.reuseIdentifier)
        dateAndSumSection.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseIdentifier)
        dateAndSumSection.register(SumCell.self, forCellReuseIdentifier: SumCell.reuseIdentifier)
        dateAndSumSection.register(SortCell.self, forCellReuseIdentifier: SortCell.reuseIdentifier)
        dateAndSumSection.dataSource = self
        dateAndSumSection.delegate = self
        view.addSubview(dateAndSumSection)
        dateAndSumSection.pinTop(to: pieChart.bottomAnchor)
        dateAndSumSection.pinBottom(to: view.bottomAnchor)
        dateAndSumSection.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        dateAndSumSection.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
    }
}

extension AnalysisViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return vm.transactions.count
        default: return 4
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "Операции"
        default: return nil
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // засунуть во вью модель
            // не через строки хардкодить, а через enum-ы
            switch indexPath.row {
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: SumCell.reuseIdentifier, for: indexPath)
                guard let sumCell = cell as? SumCell else { return cell }
                sumCell.configure(sum: vm.stringSumAll())
                sumCell.selectionStyle = .none
                return sumCell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: SortCell.reuseIdentifier, for: indexPath)
                guard let sortCell = cell as? SortCell else { return cell }
                sortCell.configure()
                sortCell.menuDelegate = self
                sortCell.selectionStyle = .none
                
                return sortCell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: DateTableCell.reuseIdentifier, for: indexPath)
                guard let dateCell = cell as? DateTableCell else { return cell }
                dateCell.configure(border: indexPath.row == 0 ? .start : .end)
                dateCell.dateDelegate = self
                dateCell.selectionStyle = .none
                return dateCell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier, for: indexPath)
            guard let categoryCell = cell as? TransactionTableViewCell else { return cell }
            let transaction = vm.transactions[indexPath.row]
            let sum = vm.stringSum(for: transaction)
            let percent = vm.stringPercent(for: transaction)
            categoryCell.configure(transaction: transaction, sum: sum, percent: percent)
            categoryCell.accessoryType = .disclosureIndicator
            categoryCell.selectionStyle = .none
            return cell
        }
    }
    
    
}

extension AnalysisViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 60
        default: return 44
        }
    }
}

extension AnalysisViewController: MenuDelegate {
    func menu(_ sortingType: SortingType) {
        vm.sort(by: sortingType)
        dateAndSumSection.reloadSections([1], with: .none)
        pieChart.animateTransition(to: vm.entities)
    }
}

extension AnalysisViewController: DateDelegate {
    func datePicker(cell: DateTableCell, newDate: Date) {
        let border = cell.border
        
        let otherCellIndex: IndexPath = {
            let idx = dateAndSumSection.indexPath(for: cell)!
            return IndexPath(row: idx.row == 0 ? 1 : 0, section: idx.section)
        }()
        
        if let otherCell = dateAndSumSection.cellForRow(at: otherCellIndex) as? DateTableCell {
            if border == .start && newDate > otherCell.getDate() {
                otherCell.setDate(newDate)
            } else if border == .end && newDate < otherCell.getDate() {
                otherCell.setDate(newDate)
            }
        } else {
            dateAndSumSection.reloadRows(at: [otherCellIndex], with: .none)
        }
        
        let startCell = dateAndSumSection.cellForRow(at: IndexPath(row: 0, section: 0)) as! DateTableCell
        let endCell = dateAndSumSection.cellForRow(at: IndexPath(row: 1, section: 0)) as! DateTableCell
        Task {
            try await vm.loadData(startDate: startCell.getDate(), endDate: endCell.getDate())
            pieChart.animateTransition(to: vm.entities)
            UIView.performWithoutAnimation {
                dateAndSumSection.reloadSections([1], with: .none)
                dateAndSumSection.layoutIfNeeded()
                dateAndSumSection.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
            }
        }
        
        
    }
}

