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

class ConversationsController: UIViewController {

    // MARK: - Properties

    private var user: User?
    private var conversations = [Conversation]()
    private var conversationsDictionary = [String: Conversation]()

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
    }

    private let newMessageButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.backgroundColor = .systemGray5
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "메시지", prefersLargeTitle: true)
    }

    // MARK: - Selectors

    @objc func showProfile() {
        let controller = ProfileController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }

    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }

    // MARK: - API

    func fetchUser() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.fetchConversationsOfUser(withUid: currentUid) { user in
            self.user = user
            log.info("현재 유저 이름: \(user.fullname)")
        }
    }

    func fetchConversations() {
        showLoader(true)

        Service.fetchConversations { conversations in
            conversations.forEach { conversations in
                let message = conversations.message
                self.conversationsDictionary[message.chatPartnerId] = conversations
            }
            
            self.showLoader(false)

            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
        }
    }

    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            log.info("현재 로그인되어 있지 않습니다.")
            presentLoginScreen()
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
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        setupLayout()
        authenticateUser()
        fetchConversations()
        fetchUser()

        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
            target: self, action: #selector(showProfile))
    }

    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
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
        return conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath) as! ConversationCell
        cell.backgroundColor = .secondarySystemBackground
        cell.conversation = conversations[indexPath.row]
        return cell
    }
}
extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
}

extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
    }
}

extension ConversationsController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
}

extension ConversationsController: AuthentificationDelegate {
    func authentificationComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchConversations()
    }
}
