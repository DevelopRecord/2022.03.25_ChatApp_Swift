//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo = 0
    case settings = 1
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
}
