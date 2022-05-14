//
//  EditUserInfoView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit

class EditUserInfoView: UIView {
    
    // MARK: - Properties
    
    private lazy var emailContainerView = EditInfoInputContainerView(subtitle: emailLabel, textField: emailTextField)
    private let emailLabel = CustomLabel(subtitle: "이메일 주소")
    let emailTextField = CustomTextField(placeholder: "이메일 주소", textString: userData!.email, keyboard: .emailAddress)
    
    private lazy var fullnameContainerView = EditInfoInputContainerView(subtitle: fullnameLabel, textField: fullnameTextField)
    private let fullnameLabel = CustomLabel(subtitle: "이름")
    let fullnameTextField = CustomTextField(placeholder: "이름", textString: userData!.fullname)

    private lazy var nickNameContainerView = EditInfoInputContainerView(subtitle: nicknameLabel, textField: nicknameTextField)
    private let nicknameLabel = CustomLabel(subtitle: "닉네임 Nickname")
    let nicknameTextField = CustomTextField(placeholder: "닉네임", textString: userData!.nickname)

    private lazy var passwordContainerView = EditInfoInputContainerView(subtitle: passwordLabel, textField: passwordTextField)
    private let passwordLabel = CustomLabel(subtitle: "비밀번호")
    let passwordTextField = CustomTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .clear
        configureConstraints()
    }
    
    func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews:
                [fullnameContainerView, nickNameContainerView, emailContainerView, passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 16

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
