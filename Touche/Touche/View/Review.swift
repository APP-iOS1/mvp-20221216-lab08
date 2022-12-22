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
            //Comment_nickName
            
            HStack{
                Text(comment.nickName ?? "")
                    .underline()
                    .padding(.bottom, 1)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(comment.createdAt ?? "")
                
            }
            //Comment_contents
            
            Spacer()
            
            Text(comment.contents ?? "")
        }
        .fontWeight(.light)
        .frame(minWidth: 370, maxWidth: 370, minHeight: 80, maxHeight: .infinity, alignment: .leading)
        .font(.system(size: 14))
//        .background(Color(UIColor.systemGray5))
        .foregroundColor(.black)
        .padding()
        
    }
}

//struct Review_Previews: PreviewProvider {
//    static var previews: some View {
//        Review(comment: Comment(contents: "은바이론먼트", nickName: "은노쨔응"))
//    }
//}
