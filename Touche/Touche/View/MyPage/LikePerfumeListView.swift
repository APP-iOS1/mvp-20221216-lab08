//
//  LikePerfumeListView.swift
//  Touche
//
//  Created by MIJU on 2022/12/21.
//

import SwiftUI

struct LikePerfumeListView: View {
    @EnvironmentObject var likePerfumeStore: LikePerfumeStore
    
    var body: some View {
        VStack {
            HStack {
                Text("\(likePerfumeStore.likePerfumeStore.count)개의 상품이 저장되었습니다.")
                Spacer()
            }
            .padding()
            Grid {
                ForEach((0 ..< likePerfumeStore.likePerfumeStore.count / 2), id: \.self) { index in
                    GridRow {
                        if likePerfumeStore.likePerfumeStore.count > 1 {
                            Spacer()
                            ListCell(perfume: likePerfumeStore.likePerfumeStore[index * 2])
                            Spacer()
                            Spacer()
                            ListCell(perfume: likePerfumeStore.likePerfumeStore[index * 2 + 1])
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("")
    }
}

struct ListCell: View {
    var perfume: Perfume
    @State var isSelected: Bool = true
    
    var body: some View {
        
        VStack(alignment: .leading) {
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
                    .overlay(
                        Image(systemName: isSelected ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 18)
                            .offset(x: 60, y: -60)
                            .foregroundColor(.black)
                            .onTapGesture {
                                isSelected.toggle()
                            }
                    )
                    
                    Text(perfume.brand?.first ?? "")
                        .unredacted()
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(perfume.name?.first ?? "")
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
    }
}

struct LikePerfumeListView_Previews: PreviewProvider {
    static var previews: some View {
        LikePerfumeListView()
    }
}


