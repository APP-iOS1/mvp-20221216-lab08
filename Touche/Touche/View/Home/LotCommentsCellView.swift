//
//  LotCommentsCellView.swift
//  Touche
//
//  Created by  장종환 on 2022/12/20.
//

import SwiftUI

struct LotCommentsCellView: View {
    var perfume: Perfume
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: String(perfume.imageUrl ?? "")),
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            Text(perfume.brand?[0] ?? "")
                .unredacted()
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Text(perfume.name?[0] ?? "")
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            HStack {
                Text("좋아요")
                Text(String(perfume.likedCount ?? 0))
                
                Text("코멘트")
                Text(String(perfume.commentsCount ?? 0))
            }
            .font(.system(size: 12))
            .foregroundColor(.gray)
        }
    }
}

struct LotCommentsCellView_Previews: PreviewProvider {
    @State static var perfume = PerfumeStore()
    
    static var previews: some View {
        LotCommentsCellView(perfume: Perfume(id: "", brand: [""], name: [""], type: [""], perfumer: [""], color: [""], imageUrl: "https://ifh.cc/g/tWTd2v.png", brandSearchCount: 0, likedCount: 0, ingredientsKr: [""], ingredientsEn: [""], releasedYear: "", commentsCount: 0))
    }
}
