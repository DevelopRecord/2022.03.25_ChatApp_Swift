//
//  UIViewController+.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/03/27.
//

import UIKit
import Then
import JGProgressHUD

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)

    /// 배경 그레디언트 적용 함수
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }

    func showLoader(_ show: Bool, withText text: String? = "로딩중") {
        view.endEditing(true)
        UIViewController.hud.textLabel.text = text

        if show {
            DispatchQueue.main.async {
                UIViewController.hud.show(in: self.view, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                UIViewController.hud.dismiss(animated: true)
            }

        }
    }
}
