//
//  CustomLabel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit

class CustomLabel: UILabel {

    init(subtitle: String) {
        super.init(frame: .zero)

        text = subtitle
        textColor = UIColor(named: "nav_item_color")
        font = UIFont.boldSystemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
