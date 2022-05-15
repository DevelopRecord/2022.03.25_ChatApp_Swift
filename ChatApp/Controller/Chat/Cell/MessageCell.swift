//
//  MessageCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/07.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class MessageCell: BaseCollectionViewCell {

    // MARK: - Properties

    public static let identifier = "MessageCell"

    var message: Message? {
        didSet { setData() }
    }

    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!

    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 32 / 2
    }

    private let textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isScrollEnabled = false
        $0.isEditable = false
    }

    private let fullnameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    private let bubbleContainer = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
    }

    // MARK: - Helpers

    func setData() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)

        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text

        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive

        profileImageView.isHidden = viewModel.shouldHideProfileImage
        fullnameLabel.isHidden = viewModel.shouldHideFullname

        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        fullnameLabel.text = viewModel.fullname
    }

    override func configureConstraints() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(8)
        }

        contentView.addSubview(fullnameLabel)
        fullnameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }

        contentView.addSubview(bubbleContainer)
        bubbleContainer.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(250)
            make.top.equalTo(fullnameLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }

        bubbleContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(4)
        }

        bubbleLeftAnchor = bubbleContainer.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
    }
}
