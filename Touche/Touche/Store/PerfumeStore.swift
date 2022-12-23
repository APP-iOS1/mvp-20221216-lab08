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
    /*
    func query(selectedColor: ColorInfo, selectedBrand: [Brand]) -> [Perfume]{
        var queryResult:[Perfume] = []
        database
            .whereField("brand", arrayContainsAny: selectedBrand.map{$0.brand})
            .whereField("color", arrayContains: selectedColor.color_name)//perfume의 색이 SelectedColor인 것을 반환
            .getDocuments(){(querySnapshot, error) in
                if let error = error{
                    print("Error getting documents: \(error)")
                }else{
                    for document in querySnapshot!.documents{
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
                        queryResult.append(perfume)
                    }
                }
                
            }//brand에 포함된 배열 중에서 SELECTEDBRAND에 속한 것들을 반환
        print("queryResult:\(queryResult)")
        return queryResult
    }
     */
}

