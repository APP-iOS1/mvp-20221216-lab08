//
//  SelectedColorButton.swift
//  Touche_2
//
//  Created by 정예슬 on 2022/12/01.
//

import SwiftUI

struct SelectedColorButtonView: View {
    @EnvironmentObject var colorStore: ColorInfoStore
    var idx: Int
 
    var buttonColor: Color {
        get {
            return colorStore.colorInfoStore[idx].isSelected ? .black : .clear
        }
    }
    
    var body: some View {
        VStack {


            Button {
                if colorStore.colorInfoStore[idx].isSelected {
                    colorStore.colorInfoStore[idx].isSelected.toggle()
                } else {
//                    for index in colorStore.colors.indices {
//                        colorStore.colors[index].isSelected = false
//                    }
                    _ = colorStore.colorInfoStore.indices.map { idx in
                        colorStore.colorInfoStore[idx].setColorFalse()
                    }
                    colorStore.colorInfoStore[idx].isSelected.toggle()
                }
            } label: {
                HStack(spacing: 20){
                    Label("Toggle Selected", systemImage: "checkmark")
                        .labelStyle(.iconOnly)
                        .foregroundColor(buttonColor)
                    Circle()
                        .fill(Color(hex: colorStore.colorInfoStore[idx].color_hex))
                        .frame(width: 40, height: 40)
                    Text(colorStore.colorInfoStore[idx].description)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
            }
            
            
        }
    }
                    
}
                              
                              // ColorExtentsion.swift

                              

extension Color {
    init(hex: String) {
        print("hexCode:\(hex)")
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
                                  
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
                                  
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

