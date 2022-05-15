//
//  LoginController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/26.
//

import UIKit

import Firebase

protocol AuthentificationControllerProtocol {
    func checkFormStatus()
}

protocol AuthentificationDelegate: AnyObject {
    func authentificationComplete()
}

class LoginController: BaseViewController {

    // MARK: - Properties

    weak var delegate: AuthentificationDelegate?

    private var loginViewModel = LoginViewModel()

    private let iconImage = UIImageView().then {
        $0.tintColor = .systemBlue
        $0.image = UIImage(systemName: "bubble.right")
    }

    private lazy var emailContainerView = InputContainerView(textField: emailTextField)
    private let emailTextField = CustomTextField(placeholder: "이메일", keyboard: .emailAddress).then {
        $0.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    private lazy var passwordContainerView = InputContainerView(textField: passwordTextField)
    private let passwordTextField = CustomTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        $0.isEnabled = false
        $0.setHeight(height: 55)
        $0.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    private let joinButton = UIButton(type: .system).then {
        let attributedTitle = NSMutableAttributedString(string: "ChatApp이 처음이신가요?  ", attributes: [.font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "회원 되기", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]))

        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Helpers

    override func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = true
    }

    override func configureConstraints() {
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }

        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading).offset(32)
            make.trailing.equalTo(view.snp.trailing).inset(32)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(32)
            make.trailing.equalTo(view.snp.trailing).inset(32)
        }

        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }

    // MARK: - Selectors

    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        showLoader(true, withText: "로그인")

        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.showLoader(false)
                self.showError("로그인 오류", error.localizedDescription)
                return
            }

            self.showLoader(false)
            self.delegate?.authentificationComplete()
        }
    }

    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            loginViewModel.email = sender.text
        } else {
            loginViewModel.password = sender.text
        }

        checkFormStatus()
    }

    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LoginController: AuthentificationControllerProtocol {
    func checkFormStatus() {
        if loginViewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        }
    }
}
