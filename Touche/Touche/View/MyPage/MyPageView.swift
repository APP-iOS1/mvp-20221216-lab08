//
//  MyPageView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI

struct MyPageView: View {
    let nation: String = "대한민국"
    var menuArray: [String] {
        get{
            ["선호 카테고리", "알림설정", "위치 서비스", "국가/지역 - \(nation)", "문의하기", "자주 묻는 질문 FAQ", "개인정보 보호정책", "이용약관"]
        }
    }
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        NavigationStack{
            if userStore.user != nil {
                WishListView()
            } else {
                MyPageNonMemberView()
            }
                
            List{ 
                Section("설정") {
                    ForEach(Array(0..<4), id: \.self) { index in
                        NavigationLink {
                            NavigationTestView()
                        } label: {
                            Text("\(menuArray[index])")
                        }
                    }
                }
                Section("고객지원") {
                    ForEach(Array(4..<8), id: \.self) { index in
                        NavigationLink {
                            NavigationTestView()
                        } label: {
                            Text("\(menuArray[index])")
                        }
                    }
                }
            }.listStyle(.plain)
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView().environmentObject(UserStore())
    }
}
