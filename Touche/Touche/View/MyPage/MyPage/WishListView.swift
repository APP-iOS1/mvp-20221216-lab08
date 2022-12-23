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
        VStack {
            HStack {
                NavigationLink {
                    LikePerfumeListView()
                } label: {
                    HStack {
                        Text("향수 관심리스트")
                            .foregroundColor(.black)
                            .font(.title2)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                VStack {
                    
                    HStack {
                        ForEach(likePerfumeStore.likePerfumeStore) { perfume in
                            WishListCell(likePerfume: perfume)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
struct WishListCell: View {
    var likePerfume: Perfume
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailView(perfume: likePerfume)
            } label: {
                VStack{
                    AsyncImage(url: URL(string: likePerfume.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(likePerfume.name?.first ?? "")
                            Text(likePerfume.brand?.first ?? "")
                        }.foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(LikePerfumeStore())
    }
}
