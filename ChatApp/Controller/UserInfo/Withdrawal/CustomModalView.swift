//
//  CustomModalView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/16.
//

import UIKit

protocol CustomModalViewDelegate: AnyObject {
    func handleLogout()
}

class CustomModalView: BaseView {
    
    // MARK: - Properties
    
    weak var delegate: CustomModalViewDelegate?
    
    private let modalView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .systemGray5
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "안녕히 가세요 👀"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let cancelButton = UIButton(type: .system).then {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray.withAlphaComponent(0.3)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
    }
    
    let withdrawalButton = UIButton(type: .system).then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemRed.withAlphaComponent(0.8)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(handleWithdrawal), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureConstraints() {
        addSubview(modalView)
        modalView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        modalView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        modalView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        modalView.addSubview(withdrawalButton)
        withdrawalButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel() {
        removeFromSuperview()
    }
    
    @objc func handleWithdrawal() {
        print("xxx")
        
        
        AuthService.shared.deleteUser { error in
            if let error = error {
                log.error("탈퇴 중 오류 발생 | \(error.localizedDescription)")
                return
            }
            
            self.delegate?.handleLogout()
        }
    }
}
