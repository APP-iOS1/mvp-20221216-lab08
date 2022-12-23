//
//  FilteringResultView.swift
//  Touche_2
//
//  Created by youngseo on 2022/11/30.
//

import SwiftUI

struct FilteringResultView: View {
    @EnvironmentObject var perfumeStore: PerfumeStore
    @State var selectedBrand:[Brand]
    @State var selectedColor:ColorInfo
    @State var queryResult:[Perfume] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    /// <#Description#>
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Text("선택한 브랜드 : ")
                    ForEach(selectedBrand, id:\.self){ item in
                        Text("\(item.brand)")
                    }
                }
                
                Divider()
                
                HStack{
                    Text("선택한 색상  :  \(selectedColor.color_name)")
                }
                
                Divider()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        
                        ForEach(queryResult, id: \.self) { value in
                            NavigationLink(destination: DetailView(perfume: value), label:{
                                LotCommentsCellView(perfume: value)
                                
                            })
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                
            }.onAppear{
                self.queryResult = query()
            }
        }
    }
    func query() -> [Perfume]{
        //selectedBrand : [Brand] 의 brand:String값들이 perfumeStore의 brand들과 일치하는 애들을 검사하고, -> Set1: [Perfume]
        //그 다음에 색상이 selectedColor.color_name과 Set1[i].color[0]들이 같은 것들을 비교해야 한다.
        var set1 : [Perfume] = []
        for item in selectedBrand{
            let brandName = item.brand
            for item2 in perfumeStore.perfumeStore{
                if brandName == item2.brand?[0]{
                    set1.append(item2)
                }
            }
        }
        var set2 : [Perfume] = []
        for item in set1{
            let color = item.color?[0]
            if selectedColor.color_name == color{
                set2.append(item)
            }
        }
        return set2
    }
}

