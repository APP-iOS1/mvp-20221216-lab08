//
//  HomeView.swift
//  Touche
//
//  Created by  장종환 on 2022/12/20.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var perfumeStore = PerfumeStore()
    @StateObject private var commentStore = CommentStore()
//    var perfume: Perfume
    
    
    //    var manyComments: [Comment] {
    //        let manyComments = commentStore.commentStore.sorted { $0.contents?.count ?? 0 < $1.contents?.count ?? 0}
    //        return manyComments
    //    }
    //
    var mostSearchedBrands: [Perfume] {
        let mostSearchedBrands = perfumeStore.perfumeStore.sorted { $0.brandSearchCount ?? 0 > $1.brandSearchCount ?? 0 }.prefix(5)
        return Array(mostSearchedBrands)
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
                    
                    ForEach(mostSearchedBrands) { count in
                        Text(count.brand?[0] ?? "")
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
                            ForEach(perfumeStore.perfumeStore) { item in
                                NavigationLink(destination: Text("hi")) {
                                    VStack(alignment: .leading) {
                                        AsyncImage(
                                            url: URL(string: String(item.imageUrl ?? "")),
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
                                        
                                        Text(item.brand?[0] ?? "")
                                            .unredacted()
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        
                                        Text(item.name?[0] ?? "")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        HStack {
                                            Text("좋아요")
                                            Text(String(item.likedCount ?? 0))
                                        }
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                    
                    // 지금 실시간 코멘트 많이 달린 향수
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
                            ForEach(perfumeStore.perfumeStore) { item in
                                NavigationLink(value: item) {
                                    LotCommentsCellView(perfume: item)
                                }
                                .navigationDestination(for: Perfume.self, destination: { item in
                                    DetailView(perfume: item, perfumeUid: item.id ?? "")
                                })
                                .padding(.leading)
                            }
                        }
                        
                        HStack {
                            ForEach(perfumeStore.perfumeStore) { item in
                                NavigationLink(destination: Text("hi")) {
                                    VStack(alignment: .leading) {
                                        AsyncImage(
                                            url: URL(string: String(item.imageUrl ?? "")),
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
                                        
                                        Text(item.brand?[0] ?? "")
                                            .unredacted()
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        
                                        Text(item.name?[0] ?? "")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        HStack {
                                            Text("좋아요")
                                            Text(String(item.likedCount ?? 0))
                                        }
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            perfumeStore.fetchPerfume()
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(comment: .init())
//    }
//}
