//
//  ToucheApp.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct ToucheApp: App {
    static let db:Firestore = Firestore.firestore()
    init() {
        FirebaseApp.configure()
        
    }

    var body: some Scene {
        let searchstore = SearchStore()
        let userStore = UserStore()
        let colorInfoStore = ColorInfoStore()
        let perfumeStore = PerfumeStore()
        let likePerfumeStore = LikePerfumeStore()
        let googleAuthModel: GoogleAuthViewModel = GoogleAuthViewModel()
        
        WindowGroup {
            ContentView()
                .environmentObject(searchstore)
                .environmentObject(userStore)
                .environmentObject(colorInfoStore)
                .environmentObject(perfumeStore)
                .environmentObject(likePerfumeStore)
                .environmentObject(googleAuthModel)
                //.environmentObject(commentStore)
        }
    }
}
