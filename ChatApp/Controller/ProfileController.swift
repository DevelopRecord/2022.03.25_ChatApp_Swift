//
//  ProfileController.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import UIKit
import Firebase
import Then
import SnapKit

class ProfileController: UIViewController {
    
    private var user: User? {
        didSet { headerView.user = user }
    }
    
    // MARK: - Properties
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.fetchConversationsOfUser(withUid: currentUid) { user in
            self.user = user
            log.debug("유저 이름: \(user.fullname)")
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        setupLayout()
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
    }
}

extension ProfileController {
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        cell.accessoryType = .disclosureIndicator
        
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView() // 헤더와 셀 사이에 약간의 간격을 줍니다
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
