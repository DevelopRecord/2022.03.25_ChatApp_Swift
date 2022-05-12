//
//  ScreenViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/11.
//

import Foundation

enum ScreenViewModel: Int, CaseIterable {
    case lightMode
    case darkMode
    case suchAsSystemSettings
    
    var description: String {
        switch self {
        case .lightMode: return "밝은 모드"
        case .darkMode: return "어두운 모드"
        case .suchAsSystemSettings: return "시스템 설정과 같이"
        }
    }
}
