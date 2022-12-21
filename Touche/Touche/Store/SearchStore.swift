//
//  SearchStore.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation
import FirebaseFirestore

class SearchStore: ObservableObject {
    @Published var searchStore: Search = Search()
    
    let database = Firestore.firestore().collection("Search")
    
    func fetchSearch() {
        database.getDocuments { (snapshot, error) in
            self.searchStore.brands.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    self.searchStore.brands.append(Brand(brand: document.documentID, isSelected: false))
                    
                }
            }
        }
    }
}
