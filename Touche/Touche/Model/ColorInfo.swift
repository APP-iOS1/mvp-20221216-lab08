//
//  ColorInfo.swift
//  Touche
//
//  Created by mac on 2022/12/20.
//

import Foundation

struct ColorInfo{
    var color_hex: String = ""
    var color_name: String = ""
    var description: String = ""
    var isSelected : Bool
    mutating func setColorFalse() {
        isSelected = false
    }
}
