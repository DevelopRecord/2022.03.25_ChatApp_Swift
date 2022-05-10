//
//  CustomInputAccessoryView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/05.
//

import UIKit
import Then
import SnapKit

protocol CustomInputAccessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {

    weak var delegate: CustomInputAccessoryViewDelegate?

    // MARK: - Properties

    private lazy var messageInputTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .systemGray4
        $0.isScrollEnabled = false
    }

    private lazy var sendButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "location.fill"), for: .normal)
        $0.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.67)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    }

    private let placeholderLabel = UILabel().then {
        $0.text = "메시지 입력"
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        autoresizingMask = .flexibleHeight

//        layer.shadowOpacity = 0.27
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath

        setupLayout()

        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return .zero
    }

    // MARK: - Helpers

    func clearMessageText() {
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
    }

    // MARK: - Selectors

    @objc func handleTextInputChange() {
        if !messageInputTextView.text.isEmpty {
            placeholderLabel.isHidden = true
            sendButton.isEnabled = true
            sendButton.backgroundColor = .secondarySystemBackground
        } else {
            placeholderLabel.isHidden = false
            sendButton.isEnabled = false
            sendButton.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.67)
        }
    }

    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
        log.debug("전송 - \(message)")
    }
}

extension CustomInputAccessoryView {
    private func setupLayout() {
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            sendButton.layer.cornerRadius = 38 / 2
            make.width.height.equalTo(38)
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
        }

        addSubview(messageInputTextView)
        messageInputTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(sendButton.snp.leading)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
        }

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageInputTextView)
            make.leading.equalTo(messageInputTextView.snp.leading).offset(10)
        }
    }
}
