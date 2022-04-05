//
//  NewMessageController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import UIKit
import Then
import SnapKit

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UIViewController {

    private var users = [User]()
    weak var delegate: NewMessageControllerDelegate?

    // MARK: - Properties

    lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewMessageCell.self, forCellReuseIdentifier: NewMessageCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleDismissal))

        configureNavigationBar(withTitle: "새로운 메시지", prefersLargeTitle: false)
        setupLayout()
    }

    // MARK: - Selectors

    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - API

    func fetchUsers() {
        Service.fetchUser { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

extension NewMessageController {
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension NewMessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewMessageCell.identifier, for: indexPath) as! NewMessageCell
        let users = users[indexPath.row]
        cell.setData(profileImage: users.profileImageUrl, nickname: users.nickname, fullname: users.fullname)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
    }
}
