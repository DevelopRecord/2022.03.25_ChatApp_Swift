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
        return message.isFromCurrentUser ? .systemPurple : .lightGray
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .black
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
    
    init(message: Message) {
        self.message = message
        
        
    }
}
