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

    private lazy var emailContainerView = UIView().then {
        $0.backgroundColor = .clear
        let iv = UIImageView()
        $0.setHeight(height: 50)
    }

    private let emailImageView = UIImageView().then {
        $0.image = UIImage(systemName: "envelope")
        $0.tintColor = .white
    }

    private lazy var passwordContainerView = UIView().then {
        $0.backgroundColor = .clear
        $0.setHeight(height: 50)
    }

    private let passwordImageView = UIImageView().then {
        $0.image = UIImage(systemName: "lock")
        $0.tintColor = .white
    }

    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("Log In", for: .normal)
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .lightGray
        $0.setHeight(height: 50)
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "Email"
        $0.textColor = .white
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.textColor = .white
        $0.isSecureTextEntry = true
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        setupLayout()
    }

    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }

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

        emailContainerView.addSubview(emailImageView)
        emailContainerView.addSubview(emailTextField)
        emailImageView.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(emailImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
        passwordContainerView.addSubview(passwordImageView)
        passwordContainerView.addSubview(passwordTextField)
        passwordImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.leading.equalTo(passwordImageView.snp.trailing).offset(8)
        }
    }
}
