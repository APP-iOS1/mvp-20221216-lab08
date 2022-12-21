//
//  ColorInfoStore.swift
//  Touche
//
//  Created by mac on 2022/12/20.
//

import Foundation
import FirebaseFirestore


class ColorInfoStore: ObservableObject {
    @Published var colorInfoStore: [ColorInfo] = []
    let database = Firestore.firestore().collection("Color")
    
    func fetchColor() {
        database.getDocuments { (snapshot, error) in
            self.colorInfoStore.removeAll()
            if let snapshot {
                for document in snapshot.documents{
                    let docData = document.data()
                    let colorHex: String? = docData["color_hex"] as? String ?? ""
                    let colorName: String? = docData["color_name"] as? String ?? ""
                    let description: String? = docData["description"] as? String ?? ""
                    
                    
                    let color: ColorInfo = ColorInfo(color_hex: colorHex ?? "", color_name: colorName ??  "", description: description ?? "",isSelected: false)
                    self.colorInfoStore.append(color)
                    
                }
            }
        }
    }
}
