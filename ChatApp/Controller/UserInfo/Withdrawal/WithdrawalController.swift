//
//  WithdrawalController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/16.
//

import UIKit

protocol WithdrawalControllerDelegate: AnyObject {
    func handleLogout()
}

class WithdrawalController: BaseViewController {

    // MARK: - Properties
    
    weak var delegate: WithdrawalControllerDelegate?

    let selfView = WithdrawalView()
    let modalView = CustomModalView()
    
    var modalBool: Bool = false

    private let withdrawalButton = UIButton(type: .system).then {
        $0.setTitle("탈퇴하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        $0.addTarget(self, action: #selector(handleWithdrawal), for: .touchUpInside)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "", prefersLargeTitle: false)
    }

    // MARK: - Helpers

    override func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        
        modalView.delegate = self
    }

    override func configureConstraints() {
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        view.addSubview(withdrawalButton)
        withdrawalButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    // MARK: - Selectors

    @objc func handleWithdrawal() {
        self.view.addSubview(self.modalView)
        self.modalView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}

extension WithdrawalController: CustomModalViewDelegate {
    func handleLogout() {
        navigationController?.popViewController(animated: true)
        delegate?.handleLogout()
    }
}
