//
//  CustomTextField.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/27.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, keyboard: UIKeyboardType = .default) {
        super.init(frame: .zero)
        setHeight(height: 55)
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        font = UIFont.boldSystemFont(ofSize: 20)
        keyboardType = keyboard
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.systemGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
