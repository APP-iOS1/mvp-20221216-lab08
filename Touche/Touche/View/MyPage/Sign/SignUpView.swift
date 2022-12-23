//
//  SignUpView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/20.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    @State var checkPassword: String = ""
    @State var nickName: String = ""
    
    // 이메일 정규식 검사
    var isEmailRuleSatisfied : Bool {
        return userStore.checkEmail(email: email) || email.isEmpty
    }
        
    // 비밀번호 형식 확인
    var isPasswordRuleSatisfied : Bool {
        return password.count > 5 || password.isEmpty
    }
        
    // 비밀번호 확인
    var isPasswordSame: Bool {
        return ((password == checkPassword) && !password.isEmpty) || checkPassword.isEmpty
    }
    // 닉네임 확인
    var isNickNameInThelist: Bool {
        return userStore.nickNameDuplicateCheck(nickName) && !nickName.isEmpty
    }
    // 회원가입 버튼
    var isSignUpDisabled: Bool {
        
        // 조건을 다 만족하면 회원가입 버튼 abled
        if isEmailRuleSatisfied &&  isPasswordRuleSatisfied && isPasswordSame && !nickName.isEmpty {
            return false
        } else { return true }// 하나라도 만족하지 않는다면 disabled
    }

    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Group {
                    Text("이메일")
                    TextField("이메일 입력", text: $email)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -8)
                    Text(!isEmailRuleSatisfied ? "올바른 형식의 이메일 주소를 입력해주세요." : "")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding(.vertical, 1)
                Group{
                    Text("비밀번호")
                    SecureField("비밀번호 입력", text: $password)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -8)
                    Text(isPasswordRuleSatisfied ? "" : "6자 이상의 비밀번호를 입력해주세요.")
                        .font(.caption)
                        .foregroundColor(.red)
                    
                    Text("비밀번호 확인")
                    SecureField("비밀번호 확인", text: $checkPassword)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -8)
                    Text(isPasswordSame ? "" : "비밀번호가 일치하지 않습니다.")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding(.vertical, 1)
                
                Group{
                    Text("닉네임")
                    TextField("닉네임 입력", text: $nickName)
                        .frame(height: 40)
                        .padding(.horizontal, 10)
                        .border(.gray)
                        .padding(.top, -8)
                    Text(isNickNameInThelist ? "이미 사용중인 닉네임 입니다." : "")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding()
            Button {
                userStore.signUp(emailAddress: email, password: password, nickname: nickName)
            } label: {
                Text("회원가입")
                    .frame(width: 360, height: 44)
                    .background(.black)
                    .foregroundColor(.white)
            }
            .disabled(isSignUpDisabled)
            .onChange(of: userStore.user) { newValue in
                if userStore.loginState == .success {
                    self.presentationMode.wrappedValue.dismiss()
                    userStore.state = .signIn
                    let user = UserInfo(email: email, nickName: nickName)
                    userStore.addUser(user)
                    email = ""
                    password = ""

                } // onchange 값이 변경되면 메인 스레드에서 작동된다.
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
