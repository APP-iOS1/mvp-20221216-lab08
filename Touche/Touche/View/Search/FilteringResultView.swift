//
//  FilteringResultView.swift
//  Touche_2
//
//  Created by youngseo on 2022/11/30.
//

import SwiftUI
import FirebaseFirestore
struct FilteringResultView: View {
    @EnvironmentObject var perfumeStore: PerfumeStore
    @State var selectedBrand:[Brand]
    @State var selectedColor:ColorInfo
    @State var queryResult:[Perfume] = []
    
    let db = ToucheApp.db
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
                                VStack{
                                    AsyncImage(url: URL(string: String(value.imageUrl ?? "")),
                                               content: { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 210, height: 210)
                                    },
                                               placeholder: {
                                        ProgressView()
                                    }
                                    ).padding(.bottom,-30)
                                    
                                    
                                    Text(value.brand?[0] ?? "")
                                        .underline()
                                        .fontWeight(.semibold)
                                        .font(.system(size: 17))
                                        .padding(.leading, 30)
                                    Text(value.name?[0] ?? "")
                                        .font(.system(size: 15))
                                        .padding(.leading, 30)
                                    Text(String(value.likedCount ?? 0))
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .padding(.leading, 30)
                                }
                            }
                            )
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                
            }.onAppear{
                self.queryResult = query()
            }
        }
    }
    func query() -> [Perfume]{
        var ret:[Perfume] = []
        db.collection("Perfume")
            .whereField("color", arrayContains: selectedColor)//perfume의 색이 SELECtedColor인 것을 반환
            .whereField("brand", arrayContainsAny: selectedBrand).getDocuments(){(querySnapshot, error) in
                if let error = error{
                    print("Error getting documents: \(error)")
                }else{
                    for document in querySnapshot!.documents{
                        let docData = document.data()
                        let id: String = document.documentID
                        let brand: [String] = docData["brand"] as? [String] ?? []
                        let name: [String] = docData["name"] as? [String] ?? []
                        let type: [String] = docData["type"] as? [String] ?? []
                        let perfumer: [String] = docData["perfumer"] as? [String] ?? []
                        let color: [String] = docData["color"] as? [String] ?? []
                        let imageUrl: String = docData["imageUrl"] as? String ?? ""
                        let brandSearchCount: Int = docData["brandSearchCount"] as? Int ?? 0
                        let likedCount: Int = docData["likedCount"] as? Int ?? 0
                        let ingredientsKr: [String] = docData["ingredients_kr"] as? [String] ?? []
                        let ingredientsEn: [String] = docData["ingredients_en"] as? [String] ?? []
                        let releasedYear: String = docData["releasedYear"] as? String ?? ""
                        let commentsCount: Int = docData["commentsCount"] as? Int ?? 0
                        
                        let perfume: Perfume = Perfume(id: id, brand: brand, name: name, type: type, perfumer: perfumer, color: color, imageUrl: imageUrl, brandSearchCount: brandSearchCount, likedCount: likedCount, ingredientsKr: ingredientsKr, ingredientsEn: ingredientsEn, releasedYear: releasedYear, commentsCount: commentsCount)
                        ret.append(perfume)
                    }
                }
                
            }//brand에 포함된 배열 중에서 SELECTEDBRAND에 속한 것들을 반환
        return ret
    }
}

