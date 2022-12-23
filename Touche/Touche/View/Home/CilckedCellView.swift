//
//  CilckedCell.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import SwiftUI

struct ClickedCellView: View {
    var perfume: Perfume
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailView(perfume: perfume)
            } label: {
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
                }
            }
        }
    }
}

struct ClickedCellView_Previews: PreviewProvider {
    @State static var perfume = PerfumeStore()
    
    static var previews: some View {
        ClickedCellView(perfume: Perfume(id: "", brand: [""], name: [""], type: [""], perfumer: [""], color: [""], imageUrl: "https://ifh.cc/g/tWTd2v.png", brandSearchCount: 0, likedCount: 0, ingredientsKr: [""], ingredientsEn: [""], releasedYear: "", commentsCount: 0))
    }
}
