//
//  AuthService.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/03.
//

import UIKit
import Firebase

class AuthService {
    public static let shared = AuthService()

    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        // 1. 이미지 업로드
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)") // Storage에 profile_images라는 폴더 이름으로 이미지 파일 저장

        ref.putData(imageData, metadata: nil) { meta, error in
            if let error = error {
                log.error("프로필 이미지 생성 중 오류 발생 | \(error.localizedDescription)")
                completion!(error)
                return
            }

            // 유저 정보 생성
            ref.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error {
                        log.error("유저 생성 중 오류 발생 | \(error.localizedDescription)")
                        completion!(error)
                        return
                    }

                    guard let uid = result?.user.uid else { return }

                    let data = ["email": credentials.email,
                        "fullname": credentials.fullname,
                        "nickname": credentials.nickname,
                        "profileImageUrl": profileImageUrl,
                        "uid": uid]

                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)

                    log.info("유저 정보 저장 완료")
                }
            }
        }
    }
    
    func updateUserInfo(credentials: UpdateUserCredentials, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Auth.auth().currentUser?.updateEmail(to: credentials.email, completion: { error in
            if let error = error {
                log.debug("이메일 변경 중 오류 발생 | \(error.localizedDescription)")
                return
            }
            
            let data = ["email": credentials.email]
            
            Firestore.firestore().collection("users").document(uid).updateData(data, completion: completion)
            
            log.info("이메일 정보 변경 완료")
        })
        
        
    }
}
