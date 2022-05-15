//
//  ScreenController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/11.
//

import UIKit

class ScreenController: UIViewController {

    // MARK: - Properties

    static let shared = ScreenController()
    var isNavBool: Bool = false
    let userDefaults = UserDefaults.standard

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.rowHeight = 64
        $0.delegate = self
        $0.dataSource = self
        $0.register(ScreenCell.self, forCellReuseIdentifier: ScreenCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavBool {
            configureNavigationBar(withTitle: "화면 설정", prefersLargeTitle: false)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        configureConstraints()

        print("선택된 indexPath.row: \(userDefaults.integer(forKey: "screenMode"))")
        updateInterfaceStyle()
    }

    func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    func updateInterfaceStyle() {
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if #available(iOS 15.0, *) {
                let windows = window.windows.first
                if userDefaults.integer(forKey: "screenMode") == 0 {
                    windows?.overrideUserInterfaceStyle = .light
                } else if userDefaults.integer(forKey: "screenMode") == 1 {
                    windows?.overrideUserInterfaceStyle = .dark
                } else {
                    windows?.overrideUserInterfaceStyle = .unspecified
                }
            }
        } else if let window = UIApplication.shared.windows.first {
            if #available(iOS 13.0, *) {
                if userDefaults.integer(forKey: "screenMode") == 0 {
                    window.overrideUserInterfaceStyle = .light
                } else if userDefaults.integer(forKey: "screenMode") == 1 {
                    window.overrideUserInterfaceStyle = .dark
                } else {
                    window.overrideUserInterfaceStyle = .unspecified
                }
            } else {
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
}

extension ScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScreenViewModel.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScreenCell.identifier, for: indexPath) as? ScreenCell ?? ScreenCell()
        cell.isSelected = indexPath.row == userDefaults.integer(forKey: "screenMode") ? true : false
        cell.accessoryType = cell.isSelected ? .checkmark : .none

        let viewModel = ScreenViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            userDefaults.set(indexPath.row, forKey: "screenMode")
            self.updateInterfaceStyle()
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
