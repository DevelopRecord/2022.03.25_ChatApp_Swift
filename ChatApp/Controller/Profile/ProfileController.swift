//
//  ProfileController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import UIKit
import Firebase
import Then
import SnapKit

protocol ProfileControllerDelegate: AnyObject {
    func handleLogout()
}

class ProfileController: UIViewController {

    weak var delegate: ProfileControllerDelegate?

    private var user: User? {
        didSet { headerView.user = user }
    }

    // MARK: - Properties

    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private let footerView = ProfileFooter()

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - API

    func fetchUser() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        showLoader(true)
        Service.fetchConversationsOfUser(withUid: currentUid) { user in
            self.showLoader(false)
            
            self.user = user
            log.debug("유저 이름: \(user.fullname)")
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        configureConstraints()
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64

        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
        footerView.delegate = self
    }
}

extension ProfileController {
    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        cell.accessoryType = .disclosureIndicator

        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }

        switch viewModel {
        case .accountInfo:
            log.debug("프로필 수정")
            let controller = UserInfoController()
            controller.isNavBool = true
            navigationController?.pushViewController(controller, animated: true)
        case .settings:
            log.debug("설정")
            let controller = SettingController()
            controller.isNavBool = true
            navigationController?.pushViewController(controller, animated: true)
        case .saveMessages:
            log.debug("메시지 백업")
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView() // 헤더와 셀 사이에 약간의 간격을 줍니다
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileController: ProfileFooterDelegate {
    func footerHandleLogout() {
        let alert = UIAlertController(title: nil, message: "로그아웃 하시겠어요?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            self.dismiss(animated: true) { // 로그아웃 전 ProfileController를 dismiss 한 뒤 로그아웃 합니다
                self.delegate?.handleLogout()
            }
        }))

        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
