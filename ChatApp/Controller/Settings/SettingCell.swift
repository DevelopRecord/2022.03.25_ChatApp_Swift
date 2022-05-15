//
//  SettingCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit
import Then
import SnapKit

class SettingCell: BaseTableViewCell {

    // MARK: - Properties

    public static let identifier = "SettingCell"

    var viewModel: SettingViewModel? {
        didSet { setData() }
    }

    private let iconView = UIView().then {
        $0.backgroundColor = .systemPurple
        $0.layer.cornerRadius = 40 / 2
    }

    private let iconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.tintColor = UIColor(named: "nav_item_color")
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    // MARK: - Helpers

    override func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews: [iconImage, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
    }

    func setData() {
        guard let viewModel = viewModel else { return }

        iconImage.image = UIImage(systemName: viewModel.iconName)
        titleLabel.text = viewModel.description
    }
}
