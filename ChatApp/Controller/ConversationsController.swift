//
//  ConversationsController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/25.
//

import UIKit
import Then
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }

    // MARK: - Selectors

    @objc func showProfile() {
        logout()
    }
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            print("현재 로그인되어 있지 않습니다.")
            presentLoginScreen()
        } else {
            print("현재 로그인 되어 있습니다.")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
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
        configureNavigationBar()
        authenticateUser()

        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain,
            target: self, action: #selector(showProfile))
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
    }

    /// iOS13 부터 네비게이션 바의 스타일 변경 대응 함수
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance // 스크롤 할 때 navigationBar의 사이즈가 컴팩트하게 합니다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = true // 타이틀 글자가 왼쪽에 크게 나오게 합니다.
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark // 상태표시줄의 색을 흰색으로 변경
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
