//
//  Review.swift
//  Touche
//
//  Created by youngseo on 2022/12/21.
//

import SwiftUI

struct Review: View {
    
    var comment: Comment
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            
            HStack{
                //Comment_nickName
                if comment.nickName == ""{
                    Text("익명의 작성자")
                        .underline()
                        .padding(.bottom, 1)
                        .fontWeight(.medium)
                }
                else{
                    Text(comment.nickName ?? "")
                        .underline()
                        .padding(.bottom, 1)
                        .fontWeight(.medium)
                }
                Spacer()
                
                //Comment_createdAt
                if comment.createdAt == ""{
                    Text("3333.12.25")
                        .padding(.bottom, 1)
                        .fontWeight(.medium)
                }
                else{
                    Text(comment.createdAt ?? "")
                        .padding(.bottom, 1)
                        .fontWeight(.medium)
                }
                
            }
            //Comment_contents
            Text(comment.contents ?? "")
                .padding(.top)
        }
        .fontWeight(.light)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .frame(minWidth: 350, maxWidth: 350, minHeight: 80, maxHeight: .infinity, alignment: .leading)
        .font(.system(size: 14))
//        .background(Color(UIColor.systemGray5))
        .foregroundColor(.black)
        
        
    }
}

struct Review_Previews: PreviewProvider {
    static var previews: some View {
        Review(comment: Comment(contents: "은바이론먼트", nickName: "은노쨔응"))
    }
}
