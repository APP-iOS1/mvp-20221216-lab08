//
//  clickedStore.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import Foundation
import FirebaseFirestore

class ClickedStore: ObservableObject {
    @Published var clicedStore: [Perfume] = []
    let database = Firestore.firestore().collection("User")
    
    func fetchClickedPerfume() {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").getDocuments { [self] (snapshot, error) in
            self.clicedStore.removeAll()
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id: String = document.documentID
                    let brand: [String] = docData["brand"] as? [String] ?? []
                    let name: [String] = docData["name"] as? [String] ?? []
                    let imageUrl: String = docData["imageUrl"] as? String ?? ""
                    let likedCount: Int = docData["likedCount"] as? Int ?? 0
                    let commentsCount: Int = docData["commentsCount"] as? Int ?? 0
                    
                    let clicked: Perfume = Perfume(id: id, brand:brand, name: name, imageUrl: imageUrl, likedCount: likedCount, commentsCount: commentsCount)
                    self.clicedStore.append(clicked)
                }
            }
        }
    }
    
    func addClickedPerfume(perfume: Perfume) {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").document(perfume.id ?? "")
            .setData([
                "brand": perfume.brand?[0] ?? "",
                "name": perfume.name?[0] ?? "",
                "imageUrl": perfume.imageUrl ?? "",
                "likedCount": perfume.likedCount ?? 0,
                "commentsCount": perfume.commentsCount ?? 0
            ])
        
        fetchClickedPerfume()
    }
}
