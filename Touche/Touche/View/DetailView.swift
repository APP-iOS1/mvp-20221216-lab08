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
    
    @StateObject var perfumeStore = PerfumeStore()
    @StateObject var commentStore = CommentStore()
    @StateObject var userStore = UserStore()
    
    var perfume: Perfume
    var perfumeUid: String = ""
    //    var comment: Comment
    //    var perfumeDict = SingletonData.shared.perfumeDictionary
    
    var body: some View {
            ScrollView{
                VStack(){
                    // 향수(Perfume_imageUrl)
                    AsyncImage(url: URL(string: perfume.imageUrl ?? "")){
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 300)
                    .padding(.vertical)
                    .background(DetailViewGradiant(perfume:perfume).padding(.top, 35).padding(.bottom, 50))
                    
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
                    .padding(.trailing, 350)
                
                
                ZStack{
                    Divider()
                        .frame(width: 70, height: 2)
                        .shadow(color: Color.gray.opacity(0.2), radius: 5)
                    //                            .overlay(Color.red)
                        .padding(.vertical, 20)
                    
                }
                
                ZStack(){
                  
                        VStack(alignment: .leading){
                            // 향수 브랜드(Perfume_brand)
                            Text(perfume.brand?[0] ?? "")
                                .underline()
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                            
                            // 향수 이름(Perfume_name)
                            Text(perfume.name?[0] ?? "")
                                .font(.system(size: 16))
                            
                        }.padding(.leading, -10)
                
                    
                    
                    // 관심있는 향수 추가(User_likePerfumes, Perfume_likedCount)
                    ZStack(alignment: .trailing) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(toggle ? .black : Color(UIColor.systemGray4))
                            .padding(.trailing, 25)
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.5)) {
                                toggle.toggle()
                            }
                        }) {
                            HeartStroke()
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.leading, -180)
                .padding(.bottom, 30)
                
                
                HStack(alignment: .center){
                    
                    
                    VStack{
                        Button(action: {
                            isMyPost = true
                        }) {
                            ZStack{
                                Text("상세 정보")
                                    .foregroundColor(isMyPost ? .white : .black)
                                    .frame(width: 185, height: 50)
                                    .background(isMyPost ? .black : .white)
                            }
                            .padding(.leading)
                        }
                        
                    }
                    
                    Button(action: {
                        isMyPost = false
                    }) {
                        ZStack{
                            Text("코멘트 / 커뮤니티")
                                .foregroundColor(isMyPost ? .black : .white)
                                .frame(width: 185, height: 50)
                                .background(isMyPost ? .white : .black)
                        }
                        .padding(.trailing)
                    }
                    
                }
                
                if isMyPost {
                    // 향수 상세 정보(Perfume_perfumer, ingredientsKr)
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("조향사")
                                .underline()
                                .fontWeight(.semibold)
                                .padding(.bottom, 2)
                            
                            Text(perfume.perfumer?[0] ?? "")
                        }
                        .padding(.bottom)
                        .padding(.leading)
                        
                        VStack(alignment: .leading){
                            Text("출시년도")
                                .underline()
                                .fontWeight(.semibold)
                                .padding(.bottom, 2)
                            
                            Text(perfume.releasedYear ?? "")
                        }
                        .padding(.leading)
                        
                        GeometryReader{ geometry in
                            VStack(alignment: .leading) {
                                Text("향수 구성 정보")
                                    .underline()
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 2)
                                
                                if perfume.ingredientsKr?.count == 3 {
                                    VStack(alignment: .leading){
                                        
                                        VStack(alignment: .leading){
                                            Text("Top")
                                            Text(perfume.ingredientsKr?[0] ?? "")
                                        }.padding(.bottom, 2)
                                        
                                        VStack(alignment: .leading){
                                            Text("Middle")
                                            
                                            Text(perfume.ingredientsKr?[1] ?? "")
                                        }.padding(.bottom, 2)
                                        
                                        VStack(alignment: .leading){
                                            Text("Bottom")
                                            
                                            Text(perfume.ingredientsKr?[2] ?? "")
                                            
                                            Spacer()
                                        }.padding(.bottom, 2)
                                        
                                    }
                                    
                                } else {
                                    VStack{
                                        Text(perfume.ingredientsKr?[0] ?? "")
                                    }}
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                            Spacer()
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    .padding(.top)
                    
                } else {
                    ScrollView {
                        Text("코멘트 작성하기")
                            .padding(.leading, -185)
                            .padding(.top)
                            .fontWeight(.semibold)
                        CommentView(perfume: perfume)
                        VStack{
                            Text("코멘트 목록")
                                .padding(.leading, -185)
                                .fontWeight(.semibold)
                            //CommentView
                            ForEach(commentStore.commentStore, id: \.self){ item in
                                Review(comment: item)
                                
                            Divider()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            Spacer()
        }

        .task{commentStore.fetchComment(perfumeID: self.perfume.id ?? "")}
    }
}


struct HeartStroke: Shape {
    func path(in rect: CGRect) -> Path {
        let path =
        Path { path in
        }
        return path
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        DetailView(item: Perfume())
        DetailView(perfume: Perfume())
    }
}
