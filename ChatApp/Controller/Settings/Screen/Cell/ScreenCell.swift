//
//  ScreenCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/11.
//

import UIKit

class ScreenCell: BaseTableViewCell {

    // MARK: - Properties

    static let identifier = "ScreenCell"

    var viewModel: ScreenViewModel? {
        didSet { setData() }
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    // MARK: - Helpers

    override func configureUI() {
        selectionStyle = .none
    }

    override func configureConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }

    func setData() {
        guard let viewModel = viewModel else { return }

        titleLabel.text = viewModel.description
    }
}
