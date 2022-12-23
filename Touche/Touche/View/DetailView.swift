//
//  DetailView.swift
//  Touche
//
//  Created by mac on 2022/12/21.
//

import SwiftUI

struct DetailView: View {
    
    @State private var toggle = false
    @State private var animateGradient = false
    @State private var showModal = false
    @State private var isMyPost: Bool = true
    
    @StateObject var commentStore = CommentStore()
    
    var perfume: Perfume
    var perfumeUid: String = ""
    
    var body: some View {

        ScrollView{
            VStack(){
                
                // 색상별 ColorBar
                /*perfumestore.color[0]번째와 asset이미지의 문자열 중복*/
                Image("\(String(describing: perfume.color?.first ?? ""))_colorbar")
                    .resizable()
                    .frame(height: 15)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                
                // ColorBar 중 향수가 해당되는 위치
                Image(systemName: "chevron.up")
                    .resizable()
                    .frame(width: 12, height: 6)
                    .padding(.top, -5)
                //                    .padding(.trailing, 350)
                
                // 향수(Perfume_imageUrl)
                AsyncImage(url: URL(string: perfume.imageUrl ?? "")){
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 250)
                .padding(.top, 20)
                .padding(.bottom)
                .background(DetailViewGradiant(perfume: perfume).padding(.top, 35).padding(.bottom, 50))
                
                ZStack{
                    Divider()
                        .frame(width: 70, height: 2)
                        .shadow(color: Color.gray.opacity(0.2), radius: 5)
                    //                            .overlay(Color.red)
                        .padding(.vertical, 20)

                }
                
                HStack(){
                    
                    VStack(alignment: .leading){
                        // 향수 브랜드(Perfume_brand)
                        Text(perfume.brand?[0] ?? "")
                            .underline()
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.bottom, 1)
                        
                        // 향수 이름(Perfume_name)
                        Text(perfume.name?[0] ?? "")
                            .font(.system(size: 16))
                        
                    }.padding(.leading, 15)
                    
                    Spacer()
                    
                    // 관심있는 향수 추가(User_likePerfumes, Perfume_likedCount)
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.5)) {
                            toggle.toggle()
                        }
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(toggle ? .black : Color(UIColor.systemGray4))
                            .padding(.trailing, 25)
                    }
                }
                
                
                
                HStack(alignment: .center){
                    
                    
                    VStack{
                        Button(action: {
                            isMyPost = true
                        }) {
                            ZStack{
                                Text("상세 정보")
                                    .foregroundColor(isMyPost ? .white : .black)
                                    .frame(width: 175, height: 50)
                                    .background(isMyPost ? .black : .white)
                                    .overlay(isMyPost ? Rectangle().stroke(.black ,lineWidth: 0.5) : Rectangle().stroke(Color(UIColor.systemGray4) ,lineWidth: 0.5))
                            }
                            .padding(.leading)
                            .padding(.trailing, -5)
                        }
                        
                    }
                    
                    Button(action: {
                        isMyPost = false
                    }) {
                        ZStack{
                            Text("코멘트 / 커뮤니티")
                                .foregroundColor(isMyPost ? .black : .white)
                                .frame(width: 175, height: 50)
                                .background(isMyPost ? .white : .black)
                                .overlay(isMyPost ? Rectangle().stroke(Color(UIColor.systemGray4) ,lineWidth: 0.5) : Rectangle().stroke(.black ,lineWidth: 0.5))
                        }
                        .padding(.trailing)
                        .padding(.leading, -5)
                    }
                    
                }
                .padding(.top)
                
                if isMyPost {
                    // 향수 상세 정보(Perfume_perfumer, ingredientsKr)
                    VStack(alignment: .leading){
                        PerfumeInfoView(perfume: perfume)
                    }
                    .frame(width: 380, alignment: .leading)
                    
                } else {
                    ScrollView {
                        VStack{
                            Text("코멘트 작성하기")
                                .padding(.leading, -175)
                                .padding(.top)
                                .fontWeight(.semibold)
                            CommentView(commentStore: commentStore, perfume: perfume)
                            
                            VStack{
                                Text("코멘트 목록")
                                    .padding(.leading, -175)
                                    .fontWeight(.semibold)
                                
                                //CommentView
                                ForEach(commentStore.commentStore, id: \.self){ item in
                                    Review(comment: item)
                                    
                                    Divider()
                                        .padding(.horizontal)
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
        .task{commentStore.fetchComment(perfumeID: self.perfume.id ?? "")}
    }
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        DetailView(item: Perfume())
//        DetailView(perfume: Perfume())
//    }
//}
