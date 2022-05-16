//
//  UserInfoCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit

class UserInfoCell: BaseTableViewCell {

    // MARK: - Properties

    public static let identifier = "UserInfoCell"

    var viewModel: UserInfoViewModel? {
        didSet { setData() }
    }
    
    var deleteViewModel: UserDeleteViewModel? {
        didSet { setDeleteData() }
    }

    private let iconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.tintColor = UIColor(named: "nav_item_color")
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    var userInfoLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
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

        contentView.addSubview(userInfoLabel)
        userInfoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
    }

    func setData() {
        guard let viewModel = viewModel else { return }

        iconImage.image = UIImage(systemName: viewModel.iconName)
        titleLabel.text = viewModel.description
        userInfoLabel.text = viewModel.userInfo
    }
    
    func setDeleteData() {
        guard let deleteViewModel = deleteViewModel else { return }
        
        titleLabel.text = deleteViewModel.description
    }
}
