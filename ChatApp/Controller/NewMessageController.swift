//
//  NewMessageController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import UIKit
import Then
import SnapKit

class NewMessageController: UIViewController {
    
    // MARK: - Properties
    
    lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.register(NewMessageCell.self, forCellReuseIdentifier: NewMessageCell.identifier)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleDismissal))
        
        configureNavigationBar(withTitle: "새로운 메시지", prefersLargeTitle: false)
        setupLayout()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewMessageController {
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension NewMessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewMessageCell.identifier, for: indexPath) as! NewMessageCell
        return cell
    }
}
