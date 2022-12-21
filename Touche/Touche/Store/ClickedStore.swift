//
//  clickedStore.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ClickedStore: ObservableObject {
    @Published var clickedStore: [Clicked] = []
    let database = Firestore.firestore().collection("User")
    
    func fetchClickedPerfume() {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").getDocuments { [self] (snapshot, error) in
            self.clickedStore.removeAll()
            
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let id: String = document.documentID
                    let brand: [String] = docData["brand"] as? [String] ?? []
                    let name: [String] = docData["name"] as? [String] ?? []
                    let imageUrl: String = docData["imageUrl"] as? String ?? ""
                    
                    let clicked: Clicked = Clicked(id: id, brand: brand, name: name, imageUrl: imageUrl)
                    self.clickedStore.append(clicked)
                }
            }
        }
    }
    
    func addClickedPerfume(_ clicked: Clicked) {
        database.document("i5yMiGuhXTQdocwzfX4nJZf4cjg1").collection("ClickedPerfume").document(clicked.id)
            .setData([
                "id": clicked.id,
                "brand": clicked.brand[0],
                "name": clicked.name[0],
                "imageUrl": clicked.imageUrl
            ])
    }
}
