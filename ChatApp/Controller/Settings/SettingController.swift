//
//  SettingController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit
import Then
import SnapKit

class SettingController: UIViewController {

    var isNavBool: Bool = false
    
    // MARK: - Properties

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isNavBool {
            navigationController?.navigationBar.isHidden = false
//            navigationController?.navigationBar.barStyle = .default
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        setupLayout()
        configureNavigationBar(withTitle: "설정", prefersLargeTitle: true)
        
        tableView.rowHeight = 64
    }
}

extension SettingController {
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SettingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingViewModel.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        cell.accessoryType = .none
        
        let viewModel = SettingViewModel(rawValue: indexPath.row)
        print("세팅뷰모델: \(viewModel)")
        cell.viewModel = viewModel
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
