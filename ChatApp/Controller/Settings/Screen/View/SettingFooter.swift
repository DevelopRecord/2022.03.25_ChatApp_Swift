//
//  SettingFooter.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/18.
//

import UIKit

class SettingFooter: BaseView {
    
    // MARK: - Properties
    
    private let appVersionLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    // MARK: - Helpers
    
    override func configureUI() {
        backgroundColor = .systemGroupedBackground
        
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
        appVersionLabel.text = String("・ 앱 버전  " + appVersion)
    }
    
    override func configureConstraints() {
        addSubview(appVersionLabel)
        appVersionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
}
