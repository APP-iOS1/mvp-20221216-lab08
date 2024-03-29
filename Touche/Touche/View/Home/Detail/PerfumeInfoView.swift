//
//  PerfumeInformationView.swift
//  Touche
//
//  Created by youngseo on 2022/12/22.
//

import SwiftUI

struct PerfumeInfoView: View {
    
    var perfume: Perfume
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("조향사")
                    .underline()
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                
                Text(perfume.perfumer?[0] ?? "")
            }
            .padding(.bottom)
            .padding(.leading)
            
            VStack(alignment: .leading){
                Text("출시년도")
                    .underline()
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                
                Text(perfume.releasedYear ?? "")
            }
            .padding(.leading)
            
                VStack(alignment: .leading) {
                    Text("향수 구성 정보")
                        .underline()
                        .fontWeight(.semibold)
                        .padding(.bottom, 1)
                    
                    if perfume.ingredientsKr?.count == 3 {
                        VStack(alignment: .leading){
                            
                            VStack(alignment: .leading){
                                Text("Top")
                                Text(perfume.ingredientsKr?[0] ?? "")
                            }.padding(.bottom, 1)
                            
                            VStack(alignment: .leading){
                                Text("Middle")
                                
                                Text(perfume.ingredientsKr?[1] ?? "")
                            }.padding(.bottom, 1)
                            
                            VStack(alignment: .leading){
                                Text("Bottom")
                                
                                Text(perfume.ingredientsKr?[2] ?? "")

                                Spacer()
                                
                            }.padding(.bottom, 1)
                            
                        }
                        
                    } else {
                        VStack{
                            Text(perfume.ingredientsKr?[0] ?? "")
                        }}
                }

            .padding()
            
        }
        .foregroundColor(.gray)
        .padding(.top)

    }
}

struct PerfumeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeInfoView(perfume: Perfume())
    }
}
