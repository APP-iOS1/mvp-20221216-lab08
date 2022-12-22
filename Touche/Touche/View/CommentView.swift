//
//  CommentView.swift
//  Touche
//
//  Created by youngseo on 2022/12/21.
//

import SwiftUI

struct CommentView: View {
    
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var contents = " 맹목적인 비난의 글은 다른 향수 사용자의 경험 및 추억을 퇴색시킬 수 있습니다."
    
    @StateObject var perfumeStore = PerfumeStore()
    @StateObject var commentStore : CommentStore
    @StateObject var userStore = UserStore()
    
    var placeholderString: String = " 맹목적인 비난의 글은 다른 향수 사용자의 경험 및 추억을 퇴색시킬 수 있습니다."
    
    var perfume: Perfume
    var comment_2: [Comment] = []
    
    var body: some View {
        
        ZStack {
            VStack() {
                //Contents(Comment) 작성하는 TextEditor
                TextEditor(text: $contents)
                    .font(.system(size: 17))
                    .scrollContentBackground(.hidden)
                    .background(Color(UIColor.systemGray6))
                    .frame(width: 370, height: 150)
                    .foregroundColor(self.contents == placeholderString ? .gray : .primary)
                    .onTapGesture {
                        if self.contents == placeholderString {
                            self.contents = ""
                        }
                    }
                    .padding(.horizontal)
                
                HStack{
                Spacer()
                    Button {
                        //완료버튼 눌렀을 때
                        let newComment: Comment = Comment(id: UUID().uuidString, contents: contents)
                        commentStore.addComment(perfumeID: perfume.id ?? "", comment: newComment)
                        contents = ""
                        print("tapped")
                    } label: {
                        Text("작성완료")
                            .font(.system(size: 17))
                            .frame(width: 100, height: 30)
                            .foregroundColor(.black)
                            .padding(.trailing)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray5) ,lineWidth: 2))
 
                    }
                }
                .foregroundColor(.black)
//                .padding(.trailing)
                Spacer()
            }
        }
        .task {
            commentStore.fetchComment(perfumeID: perfume.id ?? "")
        }
        
    }
}
//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView(perfume: Perfume(), comment: Comment(), createdAt: Date()))
//    }
//}
