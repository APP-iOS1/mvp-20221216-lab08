//
//  clickedStore.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import Foundation
import FirebaseFirestore

class ClickedStore: ObservableObject {
    @Published var clicedStore: [Clicked] = []
    let database = Firestore.firestore().collection("User")
    
    func fetchClickedPerfume() {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").getDocuments { [self] (snapshot, error) in
            self.clicedStore.removeAll()
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id: String = document.documentID
                    let imageUrl: String = docData["imageUrl"] as? String ?? ""
                    
                    let clicked: Clicked = Clicked(id: id, imageUrl: imageUrl)
                    self.clicedStore.append(clicked)
                }
            }
        }
    }
    
    func addClickedPerfume(perfume: Perfume) {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").document(perfume.id ?? "")
            .setData([
                "imageUrl": perfume.imageUrl ?? ""
            ])
        
        fetchClickedPerfume()
    }
}
