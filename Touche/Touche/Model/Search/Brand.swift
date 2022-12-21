import Foundation

struct Brand: Codable, Hashable {
    var brandID = UUID()
    var brand : String
    var isSelected : Bool
    
    mutating func setBrandFalse() {
        isSelected = false
    }
}
