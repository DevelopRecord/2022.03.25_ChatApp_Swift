//
//  ProfileFooter.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/11.
//

import UIKit
import Firebase
import Then
import SnapKit

protocol ProfileFooterDelegate: AnyObject {
    func footerHandleLogout()
}

class ProfileFooter: UIView {
    
    weak var delegate: ProfileFooterDelegate?
    
    // MARK: - Properties
    
    private lazy var logoutButton = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.backgroundColor = .secondarySystemGroupedBackground
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.footerHandleLogout()
    }
}

extension ProfileFooter {
    private func setupLayout() {
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
        }
    }
}

