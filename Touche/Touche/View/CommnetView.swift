//
//  CommnetView.swift
//  Touche
//
//  Created by youngseo on 2022/12/21.
//

import SwiftUI

struct CommentView: View {
    
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var comment = ""
    
    @StateObject var perfumeStore = PerfumeStore()
    @StateObject var commentStore = CommentStore()
    @StateObject var userStore = UserStore()
    
    
    var body: some View {
        VStack(alignment: .leading){
            //            HStack{
            //                //Comment_nickName
            //                Text()
            //                    .underline()
            //                    .padding(.leading, 30)
            //                    .padding(.bottom, -10)
            //                    .foregroundColor(Color(UIColor.systemGray2))
            //
            //
            //                Button{
            //                    commentStore.addComment(comment: Comment(id: UUID().uuidString, contents: comment, createdAt: <#T##String?#>, nickName: <#T##String?#>, writerUID: <#T##String?#>)} label: {
            //                    VStack(spacing: .zero){
            //                    }
            //                    .frame(maxWidth: .infinity)
            //                    .padding(.horizontal, 130)
            //                    .multilineTextAlignment(.center)
            //                    //                  .overlay(alignment: .topTrailing){
            //                    //                      Image(systemName: "xmark")
            //                    //                  }
            //                    .padding(.top)
            //                    .padding(.trailing, 20)
            //                }
            //                .foregroundColor(.black)
            //            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                    .shadow(color: Color.gray.opacity(0.2), radius: 5)
                    .frame(width: 360, height: 150)
                    .opacity(0.1)
                
                ScrollView {
                    TextField("맹목적인 비난의 글은 다른 향수 사용자의 \n 경험 및 추억을 퇴색시킬 수 있습니다.", text: $comment, axis: .vertical)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                
                VStack {
                    Spacer()
                    //              ModalButton(showModal: self.$showModal)
                }.padding(.vertical)
                
            }
            .padding()
            
        }
        
        Group {
            Button(action: {
                commentStore.addComment(comment: Comment())
            }) {
                
                Text("작성 완료")
                    .foregroundColor(Color(UIColor.systemGray2))
                    .padding(.leading, 240)
                    .padding(.top, -10)
            }
        }
        .padding(.bottom)
        .padding(.leading,50)
        
    }
}
struct CommnetView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
