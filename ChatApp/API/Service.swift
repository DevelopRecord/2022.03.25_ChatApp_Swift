//
//  Service.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/04.
//

import Firebase

struct Service {

    static func fetchUser() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
}
