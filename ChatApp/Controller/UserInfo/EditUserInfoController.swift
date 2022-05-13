//
//  EditUserInfoController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/13.
//

import UIKit

class EditUserInfoController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var editCompleteButton = UIButton(type: .system).then {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(handleEditComplete), for: .touchUpInside)
        
        $0.layer.cornerRadius = 10
        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = .init(width: 0, height: -8)
        $0.layer.shadowColor = UIColor.secondarySystemBackground.cgColor
        $0.layer.shadowPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: $0.layer.cornerRadius).cgPath
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        configureNavigationBar(withTitle: "내 정보 수정", prefersLargeTitle: false)
        configureConstraints()
        
    }
    
    func configureConstraints() {
        view.addSubview(editCompleteButton)
        editCompleteButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleEditComplete() {
        print("수정완료")
    }
}
