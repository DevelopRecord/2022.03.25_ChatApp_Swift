//
//  RegistrationController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/26.
//

import UIKit
import Then
import SnapKit

class RegistrationController: UIViewController {

    // MARK: - Properties

    private let plusPhotoButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "plus_photo"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
    }

    private lazy var emailContainerView = InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    private let emailTextField = CustomTextField(placeholder: "이메일")

    private lazy var fullnameContainerView = InputContainerView(image: UIImage(systemName: "person"), textField: fullnameTextField)
    private let fullnameTextField = CustomTextField(placeholder: "이름")

    private lazy var nickNameContainerView = InputContainerView(image: UIImage(systemName: "person"), textField: nicknameTextField)
    private let nicknameTextField = CustomTextField(placeholder: "닉네임")

    private lazy var passwordContainerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
    private let passwordTextField = CustomTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }

    private let joinButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .lightGray
        $0.setHeight(height: 50)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func handlePlusPhoto() {

    }

    // MARK: - Helpers

    func configureUI() {
        configureGradientLayer()
        setupLayout()

    }
}

private extension RegistrationController {
    private func setupLayout() {

        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews:
                [emailContainerView, fullnameContainerView, nickNameContainerView, passwordContainerView, joinButton])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }
    }
}
