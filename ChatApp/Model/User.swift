//
//  User.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import Foundation

struct User {
    var uid: String
    var profileImageUrl: String
    var nickname: String
    var fullname: String
    var email: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.nickname = dictionary["nickname"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
