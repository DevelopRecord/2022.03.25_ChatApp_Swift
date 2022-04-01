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

    private var registrationViewModel = RegistrationViewModel()

    private let plusPhotoButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "plus_photo"), for: .normal)
        $0.tintColor = .white
        $0.clipsToBounds = true
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

    private let signUpButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .lightGray
        $0.isEnabled = false
        $0.setHeight(height: 50)
    }

    private let previousButton = UIButton(type: .system).then {
        let attributedTitle = NSMutableAttributedString(string: "이미 아이디가 있나요?  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "로그인", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            registrationViewModel.email = sender.text
        } else if sender == passwordTextField {
            registrationViewModel.password = sender.text
        } else if sender == fullnameTextField {
            registrationViewModel.fullname = sender.text
        } else {
            registrationViewModel.nickname = sender.text
        }
        checkFormStatus()
    }

    @objc func handlePrevious() {
        navigationController?.popViewController(animated: true)
    }

    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: - Helpers

    func configureUI() {
        configureGradientLayer()
        setupLayout()
        configureNotificationObserver()
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
                [emailContainerView, passwordContainerView, fullnameContainerView, nickNameContainerView, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }

        view.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }

    private func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2

        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController: AuthentificationControllerProtocol {
    func checkFormStatus() {
        if registrationViewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .lightGray
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .lightGray.withAlphaComponent(0.67)
        }
    }
}
