//
//  clickedStore.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
class ClickedStore: ObservableObject {
    @Published var clickedStore: [Perfume] = []
    let database = Firestore.firestore().collection("User")
    
    func fetchClickedPerfume() {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").getDocuments { [self] (snapshot, error) in
            self.clickedStore.removeAll()
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id: String = document.documentID
                    let brand: [String] = docData["brand"] as? [String] ?? []
                    let name: [String] = docData["name"] as? [String] ?? []
                    let type: [String] = docData["type"] as? [String] ?? []
                    let perfumer: [String] = docData["perfumer"] as? [String] ?? []
                    let color: [String] = docData["color"] as? [String] ?? []
                    let imageUrl: String = docData["imageUrl"] as? String ?? ""
                    let brandSearchCount: Int = docData["brandSearchCount"] as? Int ?? 0
                    let likedCount: Int = docData["likedCount"] as? Int ?? 0
                    let ingredientsKr: [String] = docData["ingredients_kr"] as? [String] ?? []
                    let ingredientsEn: [String] = docData["ingredients_en"] as? [String] ?? []
                    let releasedYear: String = docData["releasedYear"] as? String ?? ""
                    let commentsCount: Int = docData["commentsCount"] as? Int ?? 0
                    
                    let perfume: Perfume = Perfume(id: id, brand: brand, name: name, type: type, perfumer: perfumer, color: color, imageUrl: imageUrl, brandSearchCount: brandSearchCount, likedCount: likedCount, ingredientsKr: ingredientsKr, ingredientsEn: ingredientsEn, releasedYear: releasedYear, commentsCount: commentsCount)
                    self.clickedStore.append(perfume)
                }
            }
        }
    }
    func addClickedPerfume(perfume: Perfume) {
        clickedStore = []
        let userID:String = "i5yMiGuhXTQdocwzfX4nJZf4cjg1"
        do {
            try database.document(userID).collection("ClickedPerfume").document(perfume.id ?? "")
                .setData(from: perfume)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        fetchClickedPerfume()
    }
}




