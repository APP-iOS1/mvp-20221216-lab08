//
//  CilckedCell.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import SwiftUI

struct ClickedCellView: View {
    var clicked: Clicked

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: String(clicked.imageUrl)),
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

            Text(clicked.brand[0])
                .unredacted()
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Text(clicked.name[0])
                .font(.system(size: 14))
                .foregroundColor(.black)

//            HStack {
//                Text("좋아요")
//                Text(String(perfume.likedCount ?? 0))
//
//                Text("코멘트")
//                Text(String(perfume.commentsCount ?? 0))
//            }
//            .font(.system(size: 12))
//            .foregroundColor(.gray)
        }
    }
}

//struct ClickedCellView_Previews: PreviewProvider {
//    @State static var perfume = PerfumeStore()
//
//    static var previews: some View {
//        LotCommentsCellView(perfume: .init())
//    }
//}
