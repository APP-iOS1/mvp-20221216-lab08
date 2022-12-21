//
//  ContentView.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var searchStore: SearchStore
    
    @EnvironmentObject var colorStore: ColorInfoStore
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var perfumeStore: PerfumeStore
    //@EnvironmentObject var commentStore: CommentStore
    
    @State var isLoading: Bool = true
    var body: some View {
        ZStack {
            // 앱 화면
            Text("Launch Screen Demo").font(.largeTitle)
            // Launch Screen
            if isLoading {
                launchScreenView
            }else{
                SearchView()
            }
            
        }
        .onAppear {
            searchStore.fetchSearch()
            colorStore.fetchColor()
            userStore.fetchUser()
            perfumeStore.fetchPerfume()
            //commentStore.fetchComment()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isLoading.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    var launchScreenView: some View {
        
        ZStack(alignment: .center) {
            
            LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color("SubPrimaryColor")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            
            
        }
        
    }
    
}
