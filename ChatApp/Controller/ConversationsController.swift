//
//  ConversationsController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/25.
//

import UIKit
import Then
import SnapKit
import Firebase

private let identifier = "ConversationsCell"

class ConversationsController: UIViewController {

    // MARK: - Properties

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.rowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    private let newMessageButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.backgroundColor = .systemPurple
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Service.fetchUser()
    }

    // MARK: - Selectors

    @objc func showProfile() {
        logout()
    }

    @objc func showNewMessage() {
        let controller = NewMessageController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }

    // MARK: - API

    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            log.info("현재 로그인되어 있지 않습니다.")
            presentLoginScreen()
        } else {
            log.info("현재 로그인 되어 있습니다.")
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            log.error("로그아웃 도중 오류 발생")
        }
    }

    func presentLoginScreen() {
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar(withTitle: "메시지", prefersLargeTitle: true)
        setupLayout()
        authenticateUser()

        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
            target: self, action: #selector(showProfile))
    }
}

extension ConversationsController {
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        view.addSubview(newMessageButton)
        newMessageButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            newMessageButton.layer.cornerRadius = 56 / 2
            make.trailing.equalTo(view.snp.trailing).inset(22)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "Test cell"
        return cell
    }
}
extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
