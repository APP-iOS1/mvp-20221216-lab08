//
//  MyPageLoginView.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import SwiftUI
import SegmentedPicker

struct MyPageLoginView: View {
    let titles: [String] = ["로그인", "회원가입"]
       @State var selectedIndex: Int?

       var body: some View {
           SegmentedPicker(
               titles,
               selectedIndex: Binding(
                   get: { selectedIndex },
                   set: { selectedIndex = $0 }),
               selectionAlignment: .bottom,
               content: { item, isSelected in
                   Text(item)
                       .foregroundColor(isSelected ? Color.black : Color.gray )
                       .padding(.horizontal, 16)
                       .padding(.vertical, 8)
               },
               selection: {
                   VStack(spacing: 0) {
                       Spacer()
                       Color.black.frame(height: 1)
                   }
               })
               .onAppear {
                   selectedIndex = 0
               }
               .animation(.easeInOut(duration: 0.3))
       }
}

struct MyPageLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageLoginView()
    }
}
