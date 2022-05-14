//
//  InputContainerView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/27.
//

import UIKit
import Then
import SnapKit

class InputContainerView: UIView {

    // MARK: - Lifecycle

    init(textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: 55)
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor

        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(snp.trailing).offset(-20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
