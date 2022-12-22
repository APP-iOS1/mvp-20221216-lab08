//
//  TextFieldClearButton.swift
//  Touche
//
//  Created by 조석진 on 2022/12/22.
//
import Foundation

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
        
        func body(content: Content) -> some View {
            HStack {
                content
                
                if !text.isEmpty {
                    Button(
                        action: { self.text = "" },
                        label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                                .padding(.vertical, 10)
    //                            .padding(.trailing, 10)
                        }
                    )
                }
            }
        }
}
