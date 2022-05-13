//
//  EditInfoInputContainerView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit
import Then
import SnapKit

class EditInfoInputContainerView: UIView {

    // MARK: - Properties

    let imageView = UIImageView().then {
        $0.alpha = 0.87
    }

    // MARK: - Lifecycle

    init(subtitle: UILabel ,textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: 100)
        backgroundColor = .clear
        textField.addLeftPadding()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor

        addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }

        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.top.equalTo(subtitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

