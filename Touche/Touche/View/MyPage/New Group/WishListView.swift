//
//  WishListView.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import SwiftUI
import FirebaseAuth
struct WishListView: View {
    @EnvironmentObject var likePerfumeStore: LikePerfumeStore
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                NavigationLink {
                    
                } label: {
                    Text("향수 관심리스트")
                }
                HStack {
                    ForEach(likePerfumeStore.likePerfumeStore) { perfume in
                        WishListCell(likePerfume: perfume)
                    }
                }
            }
        }
        .onAppear{
            likePerfumeStore.fetchLikePerfume()
        }
    }
}
struct WishListCell: View {
    var likePerfume: LikePerfume
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: likePerfume.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            Text(likePerfume.name.first ?? "")
            Text(likePerfume.brand.first ?? "")
        }
        .onAppear {
            print("likePerfume: \(likePerfume)")
        }
    }
}
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(LikePerfumeStore())
    }
}
