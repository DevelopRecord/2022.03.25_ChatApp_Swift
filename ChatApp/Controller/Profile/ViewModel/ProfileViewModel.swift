//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    case saveMessages

    var description: String {
        switch self {
        case .accountInfo: return "유저 정보"
        case .settings: return "설정"
        case .saveMessages: return "메시지 백업"
        }
    }

    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        case .saveMessages: return "envelope"
        }
    }
}
