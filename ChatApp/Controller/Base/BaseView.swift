//
//  BaseView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/15.
//

import UIKit

import Firebase
import SnapKit
import Then

class BaseView: UIView {

    // MARK: - Properties

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        backgroundColor = .secondarySystemBackground
    }

    func configureConstraints() {

    }
}
