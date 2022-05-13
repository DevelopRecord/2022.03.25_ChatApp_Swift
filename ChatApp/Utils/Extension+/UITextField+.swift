//
//  UITextField+.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit

extension UITextField {
    
    /// UITextField의 왼쪽 여백 생성 함수
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
