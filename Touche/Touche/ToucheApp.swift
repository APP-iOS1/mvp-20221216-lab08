//
//  ToucheApp.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import SwiftUI
import FirebaseCore


@main
struct ToucheApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        let userStore: UserStore = UserStore()
        let perfumeStore: PerfumeStore = PerfumeStore()
        let likePerfumeStore: LikePerfumeStore = LikePerfumeStore()
        let googleAuthModel: GoogleAuthViewModel = GoogleAuthViewModel()
        WindowGroup {
            MyPageView()
                .environmentObject(userStore)
                .environmentObject(perfumeStore)
                .environmentObject(likePerfumeStore)
                .environmentObject(googleAuthModel)
        }
    }
}
