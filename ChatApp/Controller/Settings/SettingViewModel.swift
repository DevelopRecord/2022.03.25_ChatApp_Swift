//
//  SettingViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import Foundation

enum SettingViewModel: Int, CaseIterable {
    case pushNotification
    case screenSettings

    var description: String {
        switch self {
        case .pushNotification: return "푸쉬 알림"
        case .screenSettings: return "화면 테마"
        }
    }
    
    var iconName: String {
        switch self {
        case .pushNotification: return "bell.badge"
        case .screenSettings: return "moon"
        }
    }
}
