//
//  Service.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import Firebase

struct Service {

    static func fetchUser(completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                completion(users)
            })
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var message = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    message.append(Message(dictionary: change.document.data()))
                    completion(message)
                    print("--------")
                    print("change - \(change)")
                    print("change.type - \(change.type)")
                    print("change.document.data() - \(change.document.data())")
                    print("message - \(message)")
                    print("--------")
                }
            })
        }
    }

    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
            COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
                COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
    }
}
