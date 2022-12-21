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
        ScrollView {
            HStack {
                Text("\(likePerfumeStore.likePerfumeStore.count)개의 상품이 저장되었습니다.")
                Spacer()
            }
            .padding()
            Grid {
                ForEach((0 ..< likePerfumeStore.likePerfumeStore.count / 2), id: \.self) { index in
                    GridRow {
                        if likePerfumeStore.likePerfumeStore.count > 1 {
                            ListCell(likePerfume: likePerfumeStore.likePerfumeStore[index * 2])
                            ListCell(likePerfume: likePerfumeStore.likePerfumeStore[index * 2 + 1])
                        }
                    }
                }
            }
            .onAppear {
                likePerfumeStore.fetchLikePerfume()
            }
        }
        .navigationTitle("")
    }
}
struct ListCell: View {
    var likePerfume: LikePerfume
    @State var isSelected: Bool = true
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: likePerfume.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
            } placeholder: {
                ProgressView()
            }
            .overlay(
                Image(systemName: isSelected ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 18)
                    .offset(x: 60, y: -60)
                    .foregroundColor(isSelected ? .pink : .gray)
                    .onTapGesture {
                        isSelected.toggle()
                    }
                    
            )
            HStack {
                VStack(alignment: .leading) {
                    Text(likePerfume.brand.first ?? "")
                    Text(likePerfume.name.first ?? "")
                }
                .font(.system(size: 16))
                Spacer()
            }
            .padding()
        }
        .onAppear {
            print("likePerfume: \(likePerfume)")
        }
    }
}

struct LikePerfumeListView_Previews: PreviewProvider {
    static var previews: some View {
        LikePerfumeListView()
    }
}


