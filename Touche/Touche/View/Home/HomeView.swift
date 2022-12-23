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
                ZStack {
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
                        // 고정 헤더 만들기 위해서 패딩 내리기
//                        .padding(.horizontal, 20)
//                        .padding(.top, 100)
                        
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
                            Text("최근 본 향수")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding()
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(clickedStore.clickedStore) { item in
                                    ClickedCellView(perfume: item)
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
                                    .navigationDestination(for: Perfume.self, destination: { item in
                                        DetailView(perfume: item, perfumeUid: item.id ?? "")
                                    })
                                    .simultaneousGesture(
                                        TapGesture()
                                            .onEnded({ _ in
                                                clickedStore.addClickedPerfume(perfume: item)
                                            })
                                    )
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
                                    .simultaneousGesture(
                                        TapGesture()
                                            .onEnded({ _ in
                                                clickedStore.addClickedPerfume(perfume: item)
                                            })
                                    )
                                    .padding(.leading)
                                }
                            }
                        }
                    }
//                    GeometryReader { gr in
//                        VStack {
//                            Rectangle()
//                                .fill(Color.white)
//                                .frame(height:
//                                        self.calculateHeight(minHeight: 100,
//                                                             maxHeight: 100,
//                                                             yOffset: gr.frame(in: .global).origin.y))
//                                .overlay(
//                                    HStack(spacing: 10) {
//                                        Spacer()
//                                        Image(systemName: "magnifyingglass")
//                                        Image(systemName: "bell")
//                                        Image(systemName: "bag")
//                                    }
//                                        .padding()
//                                        .font(.system(size: 20, weight: .medium))
//                                        .foregroundColor(.black)
//                                        .opacity(0.8))
//                                .offset(y: gr.frame(in: .global).origin.y < 0
//                                        ? abs(gr.frame(in: .global).origin.y)
//                                        : -gr.frame(in: .global).origin.y)
//                            Spacer() // 헤더를 맨 위로 푸시
//                        }
//                    }
                }
            }
//            .edgesIgnoringSafeArea(.vertical)
        }
        .onAppear {
            perfumeStore.fetchPerfume()
            clickedStore.fetchClickedPerfume()
        }
    }
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        if maxHeight + yOffset < minHeight {
            return minHeight
        }
        return maxHeight + yOffset
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
//
//magnifyingglass
//bell
//bag
