//
//  EditUserInfoController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit
import Firebase

protocol EditUserInfoDelegate: AnyObject {
    func editUserInfoComplete()
}

class EditUserInfoController: UIViewController {

    // MARK: - Properties

    weak var delegate: EditUserInfoDelegate?

    let selfView = EditUserInfoView()

    private var user: User? {
        didSet { userData = user }
    }

    private lazy var editCompleteButton = UIButton(type: .system).then {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(handleEditComplete), for: .touchUpInside)

        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = .init(width: 0, height: -8)
        $0.layer.shadowColor = UIColor.secondarySystemBackground.cgColor
        $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
    }

    // MARK: - API

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Service.fetchConversationsOfUser(withUid: uid) { user in
            self.user = user
            userData = user
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchUser()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        configureNavigationBar(withTitle: "내 정보 수정", prefersLargeTitle: false)

        configureConstraints()
    }

    func configureConstraints() {
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        view.addSubview(editCompleteButton)
        editCompleteButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    // MARK: - Selectors

    @objc func handleEditComplete() {
        guard let fullname = selfView.fullnameTextField.text else { return }
        guard let nickname = selfView.nicknameTextField.text else { return }
        guard let email = selfView.emailTextField.text else { return }
        guard let password = selfView.emailTextField.text else { return }

        let credentials = updateUserCredentials.init(email: email, password: password, fullname: fullname, nickname: nickname)

        showLoader(true)
        AuthService.shared.updateEmail(credentials: credentials) { error in
            if let error = error {
                self.showLoader(false)
                return
            }

            self.showLoader(false)
            self.delegate?.editUserInfoComplete()
        }
    }
}
