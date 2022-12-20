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
            Text("위시리스트를 이용하시려면\n로그인 또는 회원가입을 하세요.")
                .frame(width: .infinity, alignment: .leading)
            HStack{
                NavigationLink {
                    NavigationTestView()
                } label: {
                    Text("로그인")
                        .frame(width: 125, height: 30)
                }.tint(.black)
                
                NavigationLink {
                    NavigationTestView()
                } label: {
                    Text("회원 가입")
                        .frame(width: 125,height: 30)
                        .foregroundColor(.black)
                }.tint(.white)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct MyPageNonMemberView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageNonMemberView()
    }
}
