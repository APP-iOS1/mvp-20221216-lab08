//
//  SignInView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var googleAuthModel: GoogleAuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    private var button = GIDSignInButton()

    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("이메일")
                TextField("이메일 입력", text: $email)
                Text("비밀번호")
                SecureField("비밀번호 입력", text: $password)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            Button {
                userStore.logIn(emailAddress: email, password: password)
                self.presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("로그인")
                    .frame(width: 360, height: 44)
                    .background(.black)
                    .foregroundColor(.white)
            }
            
            GoogleSignInButton()
                .frame(width: 370, height: 35)
                .onTapGesture {
                    googleAuthModel.signIn()
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserStore())
    }
}
