//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/07.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .systemBlue : .systemGray4
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .white
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var shouldHideNickname: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
    }
    
    var nickname: String {
        guard let user = message.user else { return "(알수없음)" }
        return user.nickname
    }
    
    init(message: Message) {
        self.message = message
        
        
    }
}
