//
//  FilteringResultView.swift
//  Touche_2
//
//  Created by youngseo on 2022/11/30.
//

import SwiftUI

struct FilteringResultView: View {
    var selectedBrand:[Brand]
    var selectedColor:ColorInfo
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
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
                }
                
                ScrollView{
                
                    Spacer()
                
                    Grid(horizontalSpacing: -5, verticalSpacing: 20){
                        ForEach(0..<4){_ in
                            GridRow(alignment: .center) {
                                ForEach(0..<2){_ in
                                    NavigationLink(destination: DetailView(perfume: Perfume()), label: {
                                        VStack(alignment: .leading){
                                            Image("perfume9")
                                                .resizable()
                                                .frame(width: 210, height: 210)
                                                .padding(.bottom, -30)
                                            
                                            VStack(alignment: .leading){
                                                Text("바이레도")
                                                    .underline()
                                                    .fontWeight(.semibold)
                                                    .font(.system(size: 17))
                                                
                                                Text("오픈 스카이")
                                                    .font(.system(size: 15))
                                                
                                                Text("좋아요 50")
                                                    .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                                
                                            }
                                            .padding(.leading, 30)
                                            
                                        }
                                        .foregroundColor(.black)
                                        .font(.system(size: 13))
                                    }
                                    )
                                }
                            }

                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}
