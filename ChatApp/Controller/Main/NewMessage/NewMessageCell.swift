//
//  NewMessageCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import UIKit

class NewMessageCell: BaseTableViewCell {

    // MARK: - Properties

    public static let identifier = "NewMessageCell"

    let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    let nicknameLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    let fullnameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }

    // MARK: - Helpers

    override func configureUI() {

    }

    override func configureConstraints() {
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

    func setData(profileImage: String, nickname: String, fullname: String) {
        guard let profileImage = URL(string: profileImage) else { return }

        profileImageView.kf.setImage(with: profileImage)
        nicknameLabel.text = nickname
        fullnameLabel.text = fullname
    }
}
