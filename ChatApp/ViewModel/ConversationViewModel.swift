//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/10.
//

import Foundation

struct ConversationViewModel {

    private let conversation: Conversation

    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }

    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: date)
    }

    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
