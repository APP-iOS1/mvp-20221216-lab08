//
//  HomeView.swift
//  Touche
//
//  Created by  장종환 on 2022/12/20.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @StateObject private var perfumeStore = PerfumeStore()

    @StateObject private var clickedStore = ClickedStore()
    @EnvironmentObject var userStore: UserStore

    
    // 지금 사람들이 많이 검색한 브랜드 정렬
    var mostSearchedBrands: [Perfume] {
        let mostSearchedBrands = perfumeStore.perfumeStore.sorted { $0.brandSearchCount ?? 0 > $1.brandSearchCount ?? 0 }.prefix(5)
        return Array(mostSearchedBrands)
    }
    
    // 코멘트 많이 달린 향수 정렬 Top
    var manyCommentsTop: [Perfume] {
        let manyComments = perfumeStore.perfumeStore.sorted { $0.commentsCount ?? 0 > $1.commentsCount ?? 0 }.prefix(5)
        return Array(manyComments)
    }
    
    // 코멘트 많이 달린 향수 정렬 Bottom
    var manyCommentsBottom: [Perfume] {
        let manyComments1 = perfumeStore.perfumeStore.sorted { $0.commentsCount ?? 0 > $1.commentsCount ?? 0 }.dropFirst(5).prefix(5)
        return Array(manyComments1)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // 배너
                    ZStack (alignment: .leading) {
                        HStack {
                            Text("\n\n\n\n\n\n지금 새롭게\n추가된 향수")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(.black)
                    
                    // 더보기
                    HStack {
                        VStack(alignment: .leading) {
                            Text("지금 프로모션 중인 향수를 확인하세요")
                                .foregroundColor(.black)
                            
                            Text("더보기")
                                .underline()
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("닫기")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.gray).opacity(0.4))
                    .padding(.top, -10)
                    
                    // 지금 사람들이 많이 검색한 브랜드
                    Text("지금 사람들이 많이 검색한 브랜드")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                    
                    ForEach(mostSearchedBrands) { brand in
                        Text(brand.brand?[0] ?? "")
                            .font(.system(size: 25))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .lineSpacing(4.5)
                            .padding(.leading)
                    }
                    
                    // 내가 클릭한 향수
                    HStack {
                        Text("내가 클릭한 향수")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .padding()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(clickedStore.clickedStore) { item in
                                NavigationLink(value: item) {
                                    ClickedCellView(clicked: item)
                                }
                                .navigationDestination(for: Clicked.self, destination: { item2 in
//                                    DetailView(perfume: item, perfumeUid: item.id ?? "")
                                })
                                .padding(.leading)
                            }
                        }
                    }
                    
                    // 코멘트 많이 달린 향수
                    HStack {
                        Text("지금 실시간 코멘트 많이 달린 향수")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.top, 30)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(manyCommentsTop) { item in
                                NavigationLink(value: item) {
                                    LotCommentsCellView(perfume: item)
                                }
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded { _ in
//                                            clickedStore.addClickedPerfume(Clicked(id: item.id ?? "", imageUrl: item.imageUrl ?? ""))
                                        })
                                .navigationDestination(for: Perfume.self, destination: { item in

                                    DetailView(perfume: item, perfumeUid: item.id ?? "")

                                })
                                .padding(.leading)
                            }
                        }
                        
                        HStack {
                            ForEach(manyCommentsBottom) { item in
                                NavigationLink(value: item) {
                                    LotCommentsCellView2(perfume: item)
                                }
                                .navigationDestination(for: Perfume.self, destination: { item in
                                    DetailView(perfume: item, perfumeUid: item.id ?? "")
                                })
                                .padding(.leading)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            perfumeStore.fetchPerfume()
            clickedStore.fetchClickedPerfume()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

