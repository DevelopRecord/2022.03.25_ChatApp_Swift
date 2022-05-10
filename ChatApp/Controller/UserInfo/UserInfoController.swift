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

    private var user: User? {
        didSet { UserInfoCell().user = user }
    }

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
        fetchUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isNavBool {
            navigationController?.navigationBar.isHidden = false
//            navigationController?.navigationBar.barStyle = .default
        }
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Service.fetchConversationsOfUser(withUid: currentUid) { user in
            self.user = user
            log.debug("UserInfoController 유저네임 | \(user.fullname)")
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        configureNavigationBar(withTitle: "프로필 수정", prefersLargeTitle: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(handleDone))
        setupLayout()
        tableView.rowHeight = 64
    }

    // MARK: - Selectors

    @objc func handleDone() {
        log.debug("확인")
        navigationController?.popViewController(animated: true)
    }
}

extension UserInfoController {
    private func setupLayout() {
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
        cell.user = user

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
