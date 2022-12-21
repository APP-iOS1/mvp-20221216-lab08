//
//  Perfume.swift
//  Touche
//
//  Created by 조석진 on 2022/12/19.
//

import Foundation

struct Perfume: Codable,Identifiable, Hashable {
    var id               : String?   = nil
    var brand            : [String]? = []
    var name             : [String]? = []
    var type             : [String]? = []
    var perfumer         : [String]? = []
    var color            : [String]? = []
    var imageUrl         : String?   = nil
    var brandSearchCount : Int?      = nil
    var likedCount       : Int?      = nil
    var ingredientsKr    : [String]? = []
    var ingredientsEn    : [String]? = []
    var releasedYear     : String?   = nil
    var commentsCount    : Int?      = nil

//    enum CodingKeys: String, CodingKey {
//        case id               = "id"
//        case brand            = "brand"
//        case name             = "name"
//        case type             = "type"
//        case perfumer         = "perfumer"
//        case color            = "color"
//        case imageUrl         = "imageUrl"
//        case brandSearchCount = "brandSearchCount"
//        case likedCount       = "likedCount"
//        case ingredientsKr    = "ingredients_kr"
//        case ingredientsEn    = "ingredients_en"
//        case releasedYear     = "releasedYear"
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        brand            = try values.decodeIfPresent([String].self , forKey: .brand            )
//        name             = try values.decodeIfPresent([String].self , forKey: .name             )
//        type             = try values.decodeIfPresent([String].self , forKey: .type             )
//        perfumer         = try values.decodeIfPresent([String].self , forKey: .perfumer         )
//        color            = try values.decodeIfPresent([String].self , forKey: .color            )
//        imageUrl         = try values.decodeIfPresent(String.self   , forKey: .imageUrl         )
//        brandSearchCount = try values.decodeIfPresent(Int.self      , forKey: .brandSearchCount )
//        likedCount       = try values.decodeIfPresent(Int.self      , forKey: .likedCount       )
//        ingredientsKr    = try values.decodeIfPresent([String].self , forKey: .ingredientsKr    )
//        ingredientsEn    = try values.decodeIfPresent([String].self , forKey: .ingredientsEn    )
//        releasedYear     = try values.decodeIfPresent(Int.self      , forKey: .releasedYear     )
//
//    }
}
