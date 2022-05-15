//
//  ProfileFooter.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/11.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject {
    func footerHandleLogout()
}

class ProfileFooter: BaseView {

    // MARK: - Properties

    weak var delegate: ProfileFooterDelegate?

    private lazy var logoutButton = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }

    // MARK: - Helpers

    override func configureUI() {
        backgroundColor = .clear
    }

    override func configureConstraints() {
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - Selectors

    @objc func handleLogout() {
        delegate?.footerHandleLogout()
    }
}
