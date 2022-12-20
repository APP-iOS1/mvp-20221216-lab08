//
//  SingletonData.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//
import Foundation

class SingletonData {
    static let shared = SingletonData() // 클래스 자체를 자기 자신한테 할당
    var perfumeDictionary: [String: Perfume] = Dictionary<String, Perfume>()
    
    var likePerfumeDictionary = Dictionary<String, Set<String>>()
}
