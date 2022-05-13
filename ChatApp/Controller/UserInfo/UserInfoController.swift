//
//  UserInfoController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit
import Then
import SnapKit
import Firebase

class UserInfoController: UIViewController {

    var isNavBool: Bool = false

    private var user: User?

    // MARK: - Properties

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifier)
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
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        if let user = userData {
            configureNavigationBar(withTitle: String(user.fullname + "님의 정보"), prefersLargeTitle: false)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(handleEdit))
        configureConstraints()
        tableView.rowHeight = 64
    }

    // MARK: - Selectors

    @objc func handleEdit() {
        let controller = EditUserInfoController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension UserInfoController {
    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension UserInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfoViewModel.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath) as! UserInfoCell
        let viewModel = UserInfoViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
