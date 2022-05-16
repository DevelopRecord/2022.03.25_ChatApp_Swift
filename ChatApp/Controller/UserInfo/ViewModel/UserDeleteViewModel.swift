//
//  UserDeleteViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/05/16.
//

import Foundation

enum UserDeleteViewModel: Int, CaseIterable {
    case withdrawal
    
    var description: String {
        switch self {
        case .withdrawal: return "회원탈퇴"
        }
    }
}
