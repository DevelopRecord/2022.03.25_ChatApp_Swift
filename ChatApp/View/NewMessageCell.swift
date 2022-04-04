//
//  NewMessageCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import UIKit
import Then
import SnapKit

class NewMessageCell: UITableViewCell {
    
    public static let identifier = "NewMessageCell"
    
    // MARK: - Properties
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = .lightGray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "바보"
    }
    
    let fullnameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.text = "멍청이"
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewMessageCell {
    private func setupLayout() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            profileImageView.layer.cornerRadius = 56 / 2
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
    }
}
