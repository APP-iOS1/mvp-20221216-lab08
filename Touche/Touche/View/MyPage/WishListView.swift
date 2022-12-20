//
//  WishListView.swift
//  Touche
//
//  Created by MIJU on 2022/12/20.
//

import SwiftUI
import FirebaseAuth
struct WishListView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var perfumeStore: PerfumeStore
    
    var body: some View {
        ScrollView(.horizontal) {
            NavigationLink {
                
            } label: {
                Text("향수 관심리스트")
            }

            HStack {
                
                ForEach(perfumeStore.likePerfume) { perfume in
                    WishListCell(likePerfume: perfume)
                    
                }
                
            }
            Text("\(userStore.user?.uid ?? "")")
            
        }.onAppear{
            perfumeStore.fetchPerfume()
            userStore.fetchUser()
            userStore.getUserInfo()
            perfumeStore.getLikePerfume(userStore.myLikePerfumes)
        }
        
    }
}
struct WishListCell: View {
    var likePerfume: Perfume
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: likePerfume.imageUrl ?? ""))
        }

    }
}
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView().environmentObject(UserStore())
            .environmentObject(PerfumeStore())
    }
}
