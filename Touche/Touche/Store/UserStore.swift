//
//  UserStore.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class UserStore: ObservableObject{
    @Published var userStore: [UserInfo] = []
    let database = Firestore.firestore().collection("User")
    
    var user: User? {
        didSet { // 저장된 user 정보가 바뀌면 호출되어서 값을 업데이트
            objectWillChange.send()
        }
    }
    enum SignInState {
        case splash
        case signIn
        case signOut
    }
        
    enum LogInState {
        case success
        case fail
        case none
    }
        
    enum LoginPlatform {
        case email
        case google
        case none
    }

        
        //인증 상태를 관리하는 변수
    @Published var state: SignInState = .splash
    @Published var loginState: LogInState = .none
    @Published var loginPlatform: LoginPlatform = .none
    
    func fetchUser() {
        database.getDocuments { (snapshot, error) in
            self.userStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let id = document.documentID
                    let likePerfumes: [String] = docData["likePerfumes"] as? [String] ?? []
                    let nation: String? = docData["nation"] as? String ?? ""
                    let nickName: String? = docData["nickName"] as? String ?? ""
                    let watchList: [String] = docData["watchList"] as? [String] ?? []
                    
                    let userInfo: UserInfo = UserInfo(id: id, likePerfumes: likePerfumes, nation: nation, nickName: nickName, watchList: watchList)
                    self.userStore.append(userInfo)
                }
            }
        }
    }
    
    func addUser(_ userInfo: UserInfo) {
        database.document(userInfo.id)
            .setData([
                "likePerfumes": userInfo.likePerfumes ?? [],
                "nation": userInfo.nation ?? "",
                "nickName": userInfo.nickName ?? "",
                "watchList": userInfo.watchList ?? []])
        fetchUser()
    }
    
    func listenToLoginState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            // 로그인이 되어 있는 상태라면 user property에 user를 할당
            self.user = user
        }
        print("1")
    }
    
    // MARK: - 로그인 메서드
    func logIn(emailAddress: String, password: String) {
        Task {
            do {
                try await Auth.auth().signIn(withEmail: emailAddress, password: password)
                listenToLoginState()
                print("로그인 성공")

            } catch {
//                await handleError(message: "등록되지 않은 사용자 입니다.")
            }
        }
        self.loginState = .success
    }
    
    // MARK: - 회원가입 메서드
    // FIXME: 에러처리 필요함
    func signUp(emailAddress: String, password: String, nickname: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            } else {
                // MARK: 받아온 닉네임 정보로 사용자의 displayName 설정
                if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                    currentUser.displayName = nickname
//                    currentUser.commitChanges(completion: {error in
//                        if let error = error {
//                            print(error)
//                        } else {
//                            print("DisplayName changed")
//                        }
//                    })
                }
                self.logIn(emailAddress: emailAddress, password: password)
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
