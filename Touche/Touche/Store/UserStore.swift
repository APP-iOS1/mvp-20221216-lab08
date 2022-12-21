//
//  UserStore.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation
import FirebaseFirestore

class UserStore: ObservableObject{
    @Published var userStore: [User] = []
    let database = Firestore.firestore().collection("User")
    
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
                    
                    let user: User = User(id: id, likePerfumes: likePerfumes, nation: nation, nickName: nickName, watchList: watchList)
                    self.userStore.append(user)
                }
            }
        }
    }
    
    func addUser(_ user: User) {
        database.document(user.id)
            .setData([
                "likePerfumes": user.likePerfumes ?? [],
                "nation": user.nation ?? "",
                "nickName": user.nickName ?? "",
                "watchList": user.watchList ?? []])
        fetchUser()
    }
}
