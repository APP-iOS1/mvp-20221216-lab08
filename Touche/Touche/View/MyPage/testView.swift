//
//  testView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI

struct testView: View {
    @EnvironmentObject private var userStore: UserStore
    
    var body: some View {
        NavigationStack{
            if userStore.user != nil {
                NickNameView()
            } else {
                SignInView()
            }
        }.onAppear {
            // MARK: 뷰가 그려질때 로그인 상태를 확인하고 user 프로퍼티를 업데이트
            userStore.listenToLoginState()
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
            .environmentObject(UserStore())
    }
}
