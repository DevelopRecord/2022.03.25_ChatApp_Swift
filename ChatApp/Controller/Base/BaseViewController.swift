//
//  BaseViewController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/15.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {

    }
    
    func configureConstraints() {
        
    }
}
