//
//  MyPageNonMemberView.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import SwiftUI

struct MyPageNonMemberView: View {
    var body: some View {
        VStack {
            HStack {
                Text("위시리스트를 이용하시려면\n로그인 또는 회원가입을 하세요.")
                Spacer()
            }
            .frame(height: 80)
            .padding(.horizontal, 20)
            
            HStack{
                NavigationLink {
                    MyPageLoginView(selectedIndex: 0)
                    
                } label: {
                    Text("로그인")
                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 40)
                        .background(.black)
                        .foregroundColor(.white)
                }.tint(.black)
                
                NavigationLink {
                    MyPageLoginView(selectedIndex: 1)
                } label: {
                    Text("회원 가입")
                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 40)
                        .foregroundColor(.black)
                }.tint(.white)
            }
        }
    }
}

struct MyPageNonMemberView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageNonMemberView()
    }
}
