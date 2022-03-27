//
//  LoginController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/26.
//

import UIKit
import Then
import SnapKit

class LoginController: UIViewController {

    // MARK: - Properties

    private let iconImage = UIImageView().then {
        $0.image = UIImage(systemName: "bubble.right")
        $0.tintColor = .white
    }

    private lazy var emailContainerView = InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)

    private lazy var passwordContainerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)

    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .lightGray
        $0.setHeight(height: 50)
    }

    private let emailTextField = CustomTextField(placeholder: "이메일")

    private let passwordTextField = CustomTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }

    private let joinButton = UIButton(type: .system).then {
        let attributedTitle = NSMutableAttributedString(string: "계정이 없나요?  ", attributes: [.font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "회원가입", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.white]))

        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        setupLayout()
    }
}

private extension LoginController {
    func setupLayout() {
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }

        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(32)
            make.trailing.equalTo(view.snp.trailing).inset(32)
        }

        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
