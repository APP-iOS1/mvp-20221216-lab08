//
//  User.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation

struct UserInfo: Identifiable {
    var id: String
    var likePerfumes: [String]? = []
    var nation: String? = nil
    var nickName: String? = nil
    var watchList: [String]? = []
}
