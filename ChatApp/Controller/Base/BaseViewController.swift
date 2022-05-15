//
//  BaseViewController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/15.
//

import UIKit

import Firebase
import SnapKit
import Then

class BaseViewController: UIViewController {

    // MARK: - Properties

    private(set) var didSetupConstraints = false
    let userDefaults = UserDefaults.standard

    // MARK: - Initializing

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        self.view.backgroundColor = .secondarySystemBackground
        self.view.setNeedsUpdateConstraints()
    }

    // MARK: - Helpers

    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.configureConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    func configureConstraints() {

    }
}
