//
//  PerfumeStore.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation
import FirebaseFirestore

class PerfumeStore: ObservableObject {
    @Published var perfumeStore: [Perfume] = []
    let database = Firestore.firestore().collection("Perfume")
    
    func fetchPerfume() {
        database.getDocuments { (snapshot, error) in
            self.perfumeStore.removeAll()
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
                    self.perfumeStore.append(perfume)
                }
            }
        }
    }

//    func inputDataLikePerfume(){
//
//        for perfume in self.perfumeStore {
//            database2.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("LikePerfume").document(perfume.id ?? "")
//                .setData(["brand" : perfume.brand!,
//                          "name" : perfume.name!,
//                          "type" : perfume.type!,
//                          "perfumer" : perfume.perfumer!,
//                          "color" : perfume.color!,
//                          "imageUrl" : perfume.imageUrl ?? "",
//                          "brandSearchCount" : perfume.brandSearchCount ?? 0 ,
//                          "likedCount" : perfume.likedCount ?? 0,
//                          "ingredients_kr" : perfume.ingredientsKr ?? [],
//                          "ingredients_en" : perfume.ingredientsEn ?? [],
//                          "releasedYear" : perfume.releasedYear ?? "",
//                          "commentsCount" : perfume.commentsCount ?? 0], merge: true)
//        }
//    }
}

