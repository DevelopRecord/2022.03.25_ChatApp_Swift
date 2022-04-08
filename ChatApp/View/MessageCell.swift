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

class MessageCell: UICollectionViewCell {

    public static let identifier = "MessageCell"

    var message: Message? {
        didSet { configure() }
    }

    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!

    // MARK: - Properties

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
        $0.textColor = .white
        $0.text = "메시지 텍스트 테스트"
    }

    private let nicknameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.text = "바보"
    }

    private let bubbleContainer = UIView().then {
        $0.backgroundColor = .systemPurple
        $0.layer.cornerRadius = 12
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

    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)

        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text

        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive

        profileImageView.isHidden = viewModel.shouldHideProfileImage
        nicknameLabel.isHidden = viewModel.shouldHideNickname

        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        nicknameLabel.text = viewModel.nickname
    }
}

extension MessageCell {
    private func setupLayout() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(8)
        }

        contentView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }

        contentView.addSubview(bubbleContainer)
        bubbleContainer.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(250)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
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
