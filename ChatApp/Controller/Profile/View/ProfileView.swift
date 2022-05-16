//
//  ProfileView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/15.
//

import UIKit

class ProfileView: BaseView {
    
    // MARK: - Properties

    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.isScrollEnabled = false
        $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }
    
    // MARK: - Helpers
    
    override func configureUI() {
        backgroundColor = .systemGroupedBackground
    }
    
    override func configureConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
