//
//  BaseTableViewCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/15.
//

import UIKit

import Firebase
import Kingfisher
import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {

    // MARK: - Properties

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {

    }

    func configureConstraints() {

    }
}
