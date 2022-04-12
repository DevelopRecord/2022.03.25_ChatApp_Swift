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

    /// 진행(로딩)창 생성 함수
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

    /// iOS13 부터 네비게이션 바의 스타일 변경 대응 함수
    func configureNavigationBar(withTitle title: String, prefersLargeTitle: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance // 스크롤 할 때 navigationBar의 사이즈가 컴팩트하게 합니다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle // 타이틀 글자가 왼쪽에 크게 나오게 합니다.
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark // 상태표시줄의 색을 흰색으로 변경
    }

    /// 에러메시지 표시 함수
    func showError(_ errorTitle: String, _ errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
