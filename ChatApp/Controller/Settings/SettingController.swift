//
//  SettingController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit

class SettingController: BaseViewController {

    // MARK: - Properties

    var isNavBool: Bool = false

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.rowHeight = 64
        $0.delegate = self
        $0.dataSource = self
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "설정", prefersLargeTitle: true)

        if isNavBool {
            navigationController?.navigationBar.isHidden = false
        }
    }

    // MARK: - Helpers

    override func configureUI() {
        view.backgroundColor = .systemGroupedBackground
    }

    override func configureConstraints() {
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
        cell.accessoryType = .disclosureIndicator

        let viewModel = SettingViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewModel = SettingViewModel(rawValue: indexPath.row)

        switch viewModel {
        case .pushNotification:
            self.showToast(message: "준비중인 기능이에요.")
        case .screenSettings:
            let controller = ScreenController()
            controller.isNavBool = true
            navigationController?.pushViewController(controller, animated: true)
        case .none:
            print("none")
        }
    }
}
