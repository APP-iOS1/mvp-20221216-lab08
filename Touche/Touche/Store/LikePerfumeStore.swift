//
//  LikePerfumeStore.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class LikePerfumeStore: ObservableObject {
    @Published var likePerfumeStore: [LikePerfume] = []
    let database = Firestore.firestore().collection("User")
    let uid: String = Auth.auth().currentUser?.uid ?? ""
    
    func fetchLikePerfume() { // TODO: id 바꾸기
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("LikePerfume").getDocuments { [self] (snapshot, error) in
            self.likePerfumeStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let id: String = document.documentID
                    let brand: [String] = docData["brand"] as? [String] ?? []
                    let name: [String] = docData["name"] as? [String] ?? []
                    let imageUrl: String = docData["imageUrl"] as? String ?? ""
                    
                    let likePerfume: LikePerfume = LikePerfume(id: id, brand: brand, imageUrl: imageUrl, name: name)
                    self.likePerfumeStore.append(likePerfume)
                }
            }
        }
        
    }
}
