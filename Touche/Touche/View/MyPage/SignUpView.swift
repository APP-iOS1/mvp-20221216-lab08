//
//  SignUpView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var checkPassword: String = ""
    @State var nickName: String = ""
    @EnvironmentObject var userStore: UserStore

    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("이메일")
                TextField("이메일 입력", text: $email)
                Text("비밀번호")
                SecureField("비밀번호 입력", text: $password)
                Text("비밀번호 확인")
                SecureField("비밀번호 확인", text: $checkPassword)
                Text("닉네임")
                TextField("닉네임 입력", text: $nickName)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            Button {
                userStore.signUp(emailAddress: email, password: password, nickname: nickName)
            } label: {
                Text("회원가입")
            }
        }.onAppear{print("SignUp")}
        
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserStore())
    }
}
