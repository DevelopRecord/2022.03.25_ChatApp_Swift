//
//  WithdrawalView.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/16.
//

import UIKit

class WithdrawalView: BaseView {

    // MARK: - Properties

    let withdrawalLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.numberOfLines = 2
    }

    private let warningBulletLabel = UILabel().then {
        $0.textColor = .systemGray
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 5
    }

    // MARK: - Helpers

    override func configureUI() {
        backgroundColor = .secondarySystemBackground
        setWithdrawalLabel()
        setWarningLabel()
    }

    override func configureConstraints() {
        addSubview(withdrawalLabel)
        withdrawalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }

        addSubview(warningBulletLabel)
        warningBulletLabel.snp.makeConstraints { make in
            make.top.equalTo(withdrawalLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    func setWithdrawalLabel() {
        guard let userData = userData else { return }

        withdrawalLabel.text = String(userData.fullname + "님,\n탈퇴하기 전에 확인해주세요")
        let attrString = NSMutableAttributedString(string: withdrawalLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        withdrawalLabel.attributedText = attrString
    }

    func setWarningLabel() {
        guard let url = Bundle.main.url(forResource: "WithdrawalWarning", withExtension: "plist") else { return }
        guard let dictionary = NSDictionary(contentsOf: url) else { return }

        let warning1 = dictionary["warning1"] as? String
        let warning2 = dictionary["warning2"] as? String
        let warning3 = dictionary["warning3"] as? String
        let warning4 = dictionary["warning4"] as? String
        let warning5 = dictionary["warning5"] as? String

        let warnings: [String?] = [warning1, warning2, warning3, warning4, warning5]
        var fullString = ""

        for string: String? in warnings {
            let bulletPoint = "\u{2022} "
            let formattedString = "\(bulletPoint) \(string!)\n"

            fullString = fullString + formattedString
        }

        let attrString = NSMutableAttributedString(string: fullString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))

        warningBulletLabel.text = fullString
        warningBulletLabel.attributedText = attrString
    }
}
