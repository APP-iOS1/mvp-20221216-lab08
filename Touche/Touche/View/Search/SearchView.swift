//
//  SearchView.swift
//  Touche_2
//
//  Created by 강창현 on 2022/11/28.
//

import SwiftUI
import UIKit
import FirebaseAuth

/*
 28일 월요일 우선순위
 1. 검색 뷰 작업을 위한 JSON 파일 생성
 2. 브랜드_색상 (검색뷰 내의 대분류) 분리 작업
 3. 브랜드별 분류 작업 (브랜드 스크롤 가능)
 4. 브랜드 선택 시 상단 스페이스에  쌓이는 작업
 5. 브랜드 선택 시 브랜드 왼쪽 텍스트에 -- 바로 표시되는 작업
 
 HStack 만들어서 왼쪽에 리스트 띄우고 오른쪽에 나올 서브뷰는
 왼쪽에서 선택된 거에 따라 selectedIndex의 State값을 물고, 오른쪽 서브뷰가
 달리 나오게 하면 되겠죠?
 */

struct SearchView: View {
    
    let sectionList = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var searchStore: SearchStore
    @EnvironmentObject var colorStore: ColorInfoStore
    @State private var isToggle: Bool = false
    @State private var selectedBrand = [String]()
    @State private var selectedColor = ColorInfo( isSelected: false)
    
    var body: some View {
        VStack {
            // 페이지 상단의 필터링된 브랜드, 컬러를 보여주는 HStack
            HStack {
                VStack(alignment: .leading) {
                    // 선택된 브랜드를 보여주는 부분
                    ScrollView {
                        GridView()
                            .frame(width: 300)
                    }
                }
                // 선택된 컬러를 보여주는 부분
                VStack {
                    ForEach(colorStore.colorInfoStore.indices, id: \.self) { idx in
                        Button {
                            colorStore.colorInfoStore[idx].isSelected = false
                        } label: {
                            if colorStore.colorInfoStore[idx].isSelected {
                                HStack {
                                    Circle()
                                        .fill(Color(hex:colorStore.colorInfoStore[idx].color_hex))
                                        .frame(width: 20, height: 20)
                                    Image(systemName: "xmark")
                                }
                            }
                        }
                        .foregroundColor(.black)
                    }
                }
                .frame(width: 50)
            }
            .frame(height: 100)
            
            Divider()
            
            
            // 화면 좌측: 브랜드,색상 선택 탭  /  우측: 그에 따른 리스트
            HStack {
                
                // 화면 좌측: 브랜드,색상 선택 탭
                VStack(alignment: .leading) {
                    
                    // 브랜드 버튼
                    Button(action: {
                        isToggle = false
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("01")
                                Text("브랜드")
                            }
                            Spacer()
                            Rectangle()
                                .fill(isToggle ? Color.clear : Color.black)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 52)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // 색상 버튼
                    Button(action: {
                        isToggle = true
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("02")
                                Text("색상")
                            }
                            Spacer()
                            Rectangle()
                                .fill(isToggle ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 52)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .font(.callout)
                .padding(.leading, 10)
                .foregroundColor(.black)
                
                
                Spacer()
                
                // 브랜드, 색상 탭에 따라 보여지는 리스트
                VStack {
                    if isToggle == false {
                        // 브랜드 리스트
                        List (sectionList, id: \.self) { header in
                            Section(header: Text("\(header)")) {
                                ForEach(searchStore.searchStore.brands.indices, id: \.self) { idx in
                                    let nowBrand = searchStore.searchStore.brands[idx]
                                    if header == sectionCheck(name: nowBrand.brand) {
                                        HStack {
                                            SelectedButtonView(selectedBrand: $selectedBrand, idx: idx)
                                            Text("\(nowBrand.brand)")
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.inset)
                    } else {
                        // 색상 리스트
                        ScrollView{
                            VStack(alignment: .leading, spacing: 15){
                                ForEach(colorStore.colorInfoStore.indices, id: \.self) { idx in
                                    SelectedColorButtonView(idx: idx)
                                }
                            }
                        }.padding(.top, 50)
                    }
                }.frame(width: 300)
            }
            
            // 페이지 하단의 초기화, 적용하기 버튼 구현부
            HStack{
                
                // 브랜드, 컬러 초기화 버튼
                Button {
                    //                    for idx in perfumeStore.brands.indices {
                    //                        perfumeStore.brands[idx].isSelected = false
                    //                    }
                    _ = searchStore.searchStore.brands.indices.map { idx in
                        searchStore.searchStore.brands[idx].setBrandFalse()
                    }
                    //                    for idx in colorStore.colors.indices {
                    //                        colorStore.colors[idx].isSelected = false
                    //                }
                    _ = colorStore.colorInfoStore.indices.map { idx in
                        colorStore.colorInfoStore[idx].setColorFalse()
                    }
                } label: {
                    Label("초기화", systemImage: "arrow.clockwise")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 50)
                .background(.gray.opacity(0.3))
                .cornerRadius(8)
                
                
                if searchStore.searchStore.brands.filter{$0.isSelected == true}.count != 0 && colorStore.colorInfoStore.filter{$0.isSelected == true}.count != 0{
                    // 적용하기 버튼 -> 검색 결과
                    NavigationLink {
                        // 검색 결과 뷰
                        //예외처리.
                        FilteringResultView(selectedBrand: searchStore.searchStore.brands.filter{$0.isSelected == true}, selectedColor: colorStore.colorInfoStore.filter{$0.isSelected}[0])
                    } label: {
                        Text("적용하기")
                            .foregroundColor(.white)
                    }
                    .frame(width: 250, height: 50)
                    .background(.black)
                    .cornerRadius(8)
                }
            }
        }
        .onAppear {
            print(userStore.nickName)
        }
    }
    /// 가장 첫 초성 추출
    func sectionCheck(name: String) -> String {
        let octal = name.unicodeScalars[name.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        
        return sectionList[Int(index)]
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(PerfumeStore())
            .environmentObject(ColorInfoStore())
    }
}
