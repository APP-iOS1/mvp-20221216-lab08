//
//  SelectedButton.swift
//  Touche_2
//
//  Created by 강창현 on 2022/11/29.
//

import SwiftUI

struct SelectedButtonView: View {
    
    @EnvironmentObject var searchStore: SearchStore
    @Binding var selectedBrand: [String]
    
    var idx: Int
//    var buttonImage: String {
//        get {
//            return isSet ? "minus" : "minus"
//        }
//    }
    var buttonColor: Color {
        get {
            return searchStore.searchStore.brands[idx].isSelected ? .black : .clear
        }
    }
    
    var body: some View {
        Button {
            searchStore.searchStore
                .brands[idx].isSelected.toggle()
            selectedBrand.append(searchStore.searchStore
                .brands[idx].brand)
        } label: {
            //나타나지도 않는 레이블을 쓰는 이유: 접근성 -> 청각장애인
            Label("Toggle Selected", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundColor(buttonColor)
        }
    }
}

//struct SelectedButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedButton(idx: 0)
//            .environmentObject(PerfumeStore(brands: perfumeData))
//    }
//}
