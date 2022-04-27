//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/01.
//

import Foundation

struct RegistrationViewModel: AuthentificationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var nickname: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
                && password?.isEmpty == false
                && fullname?.isEmpty == false
                && nickname?.isEmpty == false
    }
}
