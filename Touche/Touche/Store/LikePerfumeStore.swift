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
    @Published var likePerfumeStore: [Perfume] = []
    let database = Firestore.firestore().collection("User")
    
    func fetchLikePerfume() {
        guard let uid: String = Auth.auth().currentUser?.uid else { return }
        database.document(uid).collection("LikePerfume").getDocuments { [self] (snapshot, error) in
            self.likePerfumeStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
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
                    self.likePerfumeStore.append(perfume)
                }
            }
        }
    }   
}
