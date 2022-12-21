//
//  MyPageLoginView.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import SwiftUI
import SegmentedPicker

struct MyPageLoginView: View {
    @State var selectedIndex: Int?
    let titles: [String] = ["로그인", "회원가입"]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                SegmentedPicker(
                    titles,
                    selectedIndex: Binding(
                        get: { selectedIndex },
                        set: { selectedIndex = $0}),
                    selectionAlignment: .bottom,
                    content: { item, isSelected in
                        Text(item)
                            .foregroundColor(isSelected ? Color.black : Color.gray )
                            .font(.title2)
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
                    
                }
                .animation(.easeInOut(duration: 0.3))
                Spacer()
            }
            .padding(.leading, 15)
       
            VStack {
                switch selectedIndex {
                case 0:
                    SignInView()
                default:
                    SignUpView()
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: 650)
            
        }
    }
}

struct MyPageLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageLoginView()
    }
}
