//
//  ConversationCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class ConversationCell: UITableViewCell {

    public static let identifier = "ConversationCell"

    var conversation: Conversation? {
        didSet { setData() }
    }

    // MARK: - Properties

    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50 / 2
        $0.backgroundColor = .lightGray
    }

    let fullnameLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    let messageTextLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    let timestampLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.text = "2h"
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func setData() {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)

        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        fullnameLabel.text = conversation.user.fullname
        messageTextLabel.text = conversation.message.text
        timestampLabel.text = viewModel.timestamp
    }
}

extension ConversationCell {
    private func configureConstraints() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }

        let stackView = UIStackView(arrangedSubviews: [fullnameLabel, messageTextLabel])
        stackView.axis = .vertical
        stackView.spacing = 4

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
        }

        contentView.addSubview(timestampLabel)
        timestampLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
