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
        
        // Full error: The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions 에러 발생
        let data: [String: Any] = [
            "brand": perfume.brand ?? [],
            "name": perfume.name ?? [],
            "type": perfume.type ?? [],
            "perfumer": perfume.perfumer ?? [],
            "color": perfume.color ?? [],
            "imageUrl": perfume.imageUrl ?? "",
            "brandSearchCount": perfume.brandSearchCount ?? 0,
            "likedCount": perfume.likedCount ?? 0,
            "ingredients_kr": perfume.ingredientsKr ?? [],
            "ingredients_en": perfume.ingredientsEn ?? [],
            "releasedYear": perfume.releasedYear ?? "",
            "commentsCount": perfume.commentsCount ?? 0
        ]
        
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").document(perfume.id ?? "").setData(data) { err in
            if let error = err {
                print(error.localizedDescription)
            }
        }
        
        fetchClickedPerfume()
    }
}




