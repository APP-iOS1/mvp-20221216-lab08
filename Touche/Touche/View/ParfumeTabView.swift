//
//  ParfumeTabView.swift
//  Touche_2
//
//  Created by youngseo on 2022/11/29.
//

import SwiftUI

struct ParfumeTabView: View {
    @State private var selectedIndex = 0
    @State private var touchTab = false
    let tabBarNames = ["홈", "카테고리", "내 계정"]
    
    var body: some View {
        NavigationStack {
            GeometryReader{geometry in
                VStack{
                    ZStack() {
                        switch selectedIndex{
                        case 0:
                            HomeView()
                        case 1:
                            HomeView()
                        case 2:
                            HomeView()
                        default:
                            HomeView()
                        }
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        
                        ForEach(0..<3) { num in
                            VStack(alignment: .center){
                                Text(tabBarNames[num])
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : Color(.tertiaryLabel))
                            }
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        selectedIndex = num
                                    }
                            )
                            
                            Spacer()
                        }
                    }
                    
                    HStack{
                        switch selectedIndex{
                        case 0 :
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / -2.320)
                        case 1:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / -12.90)
                           
                        case 2:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / 1.9)
                        default :
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                        }
                    }.padding(.top, -5)
                }
            }
        }
    }
}

struct ParfumeTabView_Previews: PreviewProvider {
    static var previews: some View {
        ParfumeTabView()
    }
}
