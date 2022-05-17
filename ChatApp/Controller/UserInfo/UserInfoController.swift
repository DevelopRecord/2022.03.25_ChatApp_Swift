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

protocol UserInfoControllerDelegate: AnyObject {
    func handleLogout()
}

class UserInfoController: BaseViewController {

    // MARK: - Properties
    
    weak var delegate: UserInfoControllerDelegate?

    var isNavBool: Bool = false

    private var user: User?

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isNavBool {
            navigationController?.navigationBar.isHidden = false
        }
    }

    // MARK: - Helpers

    override func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        if let user = userData {
            configureNavigationBar(withTitle: String(user.fullname + "님의 정보"), prefersLargeTitle: false)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(handleEdit))
        configureConstraints()
        tableView.rowHeight = 64
    }

    override func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Selectors

    @objc func handleEdit() {
        let controller = EditUserInfoController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension UserInfoController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return UserInfoViewModel.allCases.count
        } else if section == 1 {
            return UserDeleteViewModel.allCases.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath) as! UserInfoCell
        let viewModel = UserInfoViewModel(rawValue: indexPath.row)
        let deleteViewModel = UserDeleteViewModel(rawValue: indexPath.row)
        if indexPath.section == 0 {
            cell.viewModel = viewModel
        } else if indexPath.section == 1 {
            cell.deleteViewModel = deleteViewModel
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            print("section 0")
        } else if indexPath.section == 1 {
            let controller = WithdrawalController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension UserInfoController: EditUserInfoDelegate {
    func editUserInfoComplete() {
        self.navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
        showToast(message: "유저 정보가 변경 되었습니다.")
    }
}

extension UserInfoController: WithdrawalControllerDelegate {
    func handleLogout() {
        navigationController?.popViewController(animated: true)
        delegate?.handleLogout()
    }
}
