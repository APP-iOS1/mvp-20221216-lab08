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
            Text(comment.nickName ?? "")
                .underline()
                .padding(.bottom, 1)
                .fontWeight(.medium)
            //Comment_contents
            Text(comment.contents ?? "")
        }
        .fontWeight(.light)
        .frame(width: 370, height: 80)
        .padding(.leading, -20)
        .font(.system(size: 14))
        .background(.gray)
        .foregroundColor(.black)
        
    }
}

//struct Review_Previews: PreviewProvider {
//    static var previews: some View {
//        Review(comment: <#Comment#>)
//    }
//}
