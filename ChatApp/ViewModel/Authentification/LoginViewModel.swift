//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/01.
//

import Foundation

protocol AuthentificationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthentificationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
