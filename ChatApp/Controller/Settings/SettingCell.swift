//
//  SettingCell.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit
import Then
import SnapKit

class SettingCell: UITableViewCell {

    public static let identifier = "SettingCell"
    
    var viewModel: SettingViewModel? {
        didSet { setData() }
    }
    
    // MARK: - Properties

    private let iconView = UIView().then {
        $0.backgroundColor = .systemPurple
        $0.layer.cornerRadius = 40 / 2
    }

    private let iconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.tintColor = .white
    }

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    var switchToggle = UISwitch().then {
        $0.addTarget(self, action: #selector(handleSwitchToggle), for: .touchUpInside)
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
    
    func setData() {
        guard let viewModel = viewModel else { return }

        iconImage.image = UIImage(systemName: viewModel.iconName)
        titleLabel.text = viewModel.description
    }
    
    // MARK: - Selectors
    
    @objc func handleSwitchToggle() {
        if switchToggle.isOn {
            print("ON")
        } else {
            print("OFF")
        }
    }
}

extension SettingCell {
    private func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews: [iconImage, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
    }
}
