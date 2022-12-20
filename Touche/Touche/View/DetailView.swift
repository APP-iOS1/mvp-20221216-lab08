//
//  DetailView.swift
//  Touche
//
//  Created by youngseo on 2022/12/20.
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
    var perfumeDict = SingletonData.shared.perfumeDictionary
    
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
                    .background(DetailViewGradiant().padding(.top, 35).padding(.bottom, 50))
                    
                    // 색상별 ColorBar
                    Image("ColorBar_Green")
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
                            VStack{
                                //CommnetView
                                CommentView()
                                
                                ForEach (commentStore.commentStore){ comment in
                                    Review()
                                }
                            }
                            
                        }
                    }
                }
                .padding()
                Spacer()
            }
    }
}

struct Review: View {
    
    @StateObject var perfumeStore = PerfumeStore()
    @StateObject var commentStore = CommentStore()
    @StateObject var userStore = UserStore()
    
    var body: some View{
        
        VStack(alignment: .leading){
            //Comment_nickName
            Text("Comment_nickName")
                .underline()
                .padding(.bottom, 1)
                .fontWeight(.medium)
            //Comment_contents
            Text("Comment_contents")
        }
        .fontWeight(.light)
        .frame(width: 370, height: 80)
        .padding(.leading, -20)
        .font(.system(size: 14))
        .background(.gray)
        .foregroundColor(.black)
    }
}


struct CommentView: View {
    
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var comment = ""
    
    @StateObject var perfumeStore = PerfumeStore()
    @StateObject var commentStore = CommentStore()
    @StateObject var userStore = UserStore()
    
    
    var body: some View {
        VStack(alignment: .leading){
            //            HStack{
            //                //Comment_nickName
            //                Text()
            //                    .underline()
            //                    .padding(.leading, 30)
            //                    .padding(.bottom, -10)
            //                    .foregroundColor(Color(UIColor.systemGray2))
            //
            //
            //                Button{
            //                    commentStore.addComment(comment: Comment(id: UUID().uuidString, contents: comment, createdAt: <#T##String?#>, nickName: <#T##String?#>, writerUID: <#T##String?#>)} label: {
            //                    VStack(spacing: .zero){
            //                    }
            //                    .frame(maxWidth: .infinity)
            //                    .padding(.horizontal, 130)
            //                    .multilineTextAlignment(.center)
            //                    //                  .overlay(alignment: .topTrailing){
            //                    //                      Image(systemName: "xmark")
            //                    //                  }
            //                    .padding(.top)
            //                    .padding(.trailing, 20)
            //                }
            //                .foregroundColor(.black)
            //            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                    .shadow(color: Color.gray.opacity(0.2), radius: 5)
                    .frame(width: 360, height: 150)
                    .opacity(0.1)
                
                ScrollView {
                    TextField("맹목적인 비난의 글은 다른 향수 사용자의 \n 경험 및 추억을 퇴색시킬 수 있습니다.", text: $comment, axis: .vertical)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                
                VStack {
                    Spacer()
                    //              ModalButton(showModal: self.$showModal)
                }.padding(.vertical)
                
            }
            .padding()
            
        }
        
        Group {
            Button(action: {
                commentStore.addComment(comment: Comment())
            }) {
                
                Text("작성 완료")
                    .foregroundColor(Color(UIColor.systemGray2))
                    .padding(.leading, 240)
                    .padding(.top, -10)
            }
        }
        .padding(.bottom)
        .padding(.leading,50)
        
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
