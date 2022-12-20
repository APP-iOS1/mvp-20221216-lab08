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
    @Published var userStore: [User2] = []
    let database = Firestore.firestore().collection("User")
    var myLikePerfumes: [String] = []
    var user: User? {
        didSet { // 저장된 user 정보가 바뀌면 호출되어서 값을 업데이트
            objectWillChange.send()
        }
    }
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
                    
                    let user2: User2 = User2(id: id, likePerfumes: likePerfumes, nation: nation, nickName: nickName, watchList: watchList)
                    self.userStore.append(user2)
                    
                    if self.user?.uid == id {
                        self.myLikePerfumes = likePerfumes
                    }
                }
                print(self.userStore)
            }
        }
    }
    
    func addUser(_ user: User2) {
        database.document(user.id)
            .setData([
                "likePerfumes": user.likePerfumes ?? [],
                "nation": user.nation ?? "",
                "nickName": user.nickName ?? "",
                "watchList": user.watchList ?? []])
        fetchUser()
    }
    
    // MARK: - 사용자의 로그인 여부를 확인하기 위한 메서드
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
                print("로그인 실패")
//                await handleError(message: "등록되지 않은 사용자 입니다.")
            }
        }
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
    func getUserInfo() {
        database.document(user?.uid ?? "").getDocument { (snapshot, error) in
            if let snapshot {
                let docData = snapshot.data()
                let id = snapshot.documentID
                let likePerfumes: [String] = docData?["likePerfumes"] as? [String] ?? []
                let nation: String? = docData?["nation"] as? String ?? ""
                let nickName: String? = docData?["nickName"] as? String ?? ""
                let watchList: [String] = docData?["watchList"] as? [String] ?? []
                
                let user2: User2 = User2(id: id, likePerfumes: likePerfumes, nation: nation, nickName: nickName, watchList: watchList)
                self.userStore.append(user2)
                
                if self.user?.uid == id {
                    self.myLikePerfumes = likePerfumes
                }
            }
        }
        print(self.userStore)
    }
}


