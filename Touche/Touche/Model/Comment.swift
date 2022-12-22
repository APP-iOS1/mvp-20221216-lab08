//
//  Comment.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation

struct Comment: Identifiable, Hashable {
    var id: String? = nil
    var contents: String? = nil
    var createdAt: Date
    var nickName: String? = nil
    var writerUID: String? = nil
    
//    var createdDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ko_kr")
//        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
//        dateFormatter.dateFormat = "yyyy년 MM월 dd일" // "yyyy-MM-dd HH:mm:ss"
//
//        let dateCreatedAt = createdAt
//
//        return dateFormatter.string(from: dateCreatedAt)
//    }
}
