//
//  NickNameView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI

struct NickNameView: View {
    @EnvironmentObject var userStore: UserStore
    var body: some View {
        VStack{
            Text("\(userStore.user?.displayName ?? "")")
            Text("nickName")
            Button {
                userStore.logOut()
            } label: {
                Text("로그아웃")
            }

        }.onAppear{print("nickName")}
    }
}

struct NickNameView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameView()
            .environmentObject(UserStore())
    }
}
