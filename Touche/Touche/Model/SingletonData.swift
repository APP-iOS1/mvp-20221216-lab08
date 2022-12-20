//
//  SingletonData.swift
//  Touche
//
//  Created by youngseo on 2022/12/20.
//

import Foundation

class SingletonData{
    static let shared = SingletonData()
    var perfumeDictionary: [String: Perfume] = Dictionary<String, Perfume>()
}
