//
//  UserInfoCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit
import Then
import SnapKit
import Firebase

class UserInfoCell: UITableViewCell {

    public static let identifier = "UserInfoCell"

    var viewModel: UserInfoViewModel? {
        didSet { setData() }
    }

    // MARK: - Properties

    private let iconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.tintColor = .white
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    var userInfoLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func setUserInfo(fullname: String?) {
        userInfoLabel.text = fullname
    }

    func setData() {
        guard let viewModel = viewModel else { return }
        iconImage.image = UIImage(systemName: viewModel.iconName)
        titleLabel.text = viewModel.description
        userInfoLabel.text = viewModel.userInfo
    }
}

extension UserInfoCell {
    private func configureConstraints() {
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
}
