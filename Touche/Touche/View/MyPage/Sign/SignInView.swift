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
    @EnvironmentObject var likePerfumeStore: LikePerfumeStore
    @State var email: String = ""
    @State var password: String = ""
    private var button = GIDSignInButton()

    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 20){
                
                    Text("이메일")
                    TextField("이메일 입력", text: $email)
                        .textInputAutocapitalization(.never) // 대문자 입력 방지
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -13)
                    
                    Text("비밀번호")
                    SecureField("비밀번호 입력", text: $password)
                        .textInputAutocapitalization(.never)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -13)
            }
            .padding()
            Button {
                userStore.logIn(emailAddress: email, password: password)
            } label: {
                Text("로그인")
                    .frame(width: 360, height: 44)
                    .background(.black)
                    .foregroundColor(.white)
            }
            .disabled(email.isEmpty || password.isEmpty )
            .onChange(of: userStore.user) { newValue in
                if userStore.loginState == .success {
                    likePerfumeStore.fetchLikePerfume()
                    self.presentationMode.wrappedValue.dismiss()
                    userStore.state = .signIn
                    email = ""
                    password = ""
                } // onchange 값이 변경되면 메인 스레드에서 작동된다.
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
