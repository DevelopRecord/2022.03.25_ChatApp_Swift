//
//  Extensions.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/26.
//

import UIKit

extension UIView {
    
    /// 프로퍼티에서 사용하기 위해 만든 높이 지정 함수
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// 프로퍼티에서 사용하기 위해 만든 너비 지정 함수
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
