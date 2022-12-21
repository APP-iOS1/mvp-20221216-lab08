//
//  BrandListView.swift
//  Touche
//
//  Created by mac on 2022/12/20.
//

import SwiftUI

struct BrandListView: View {
    @EnvironmentObject var searchStore: SearchStore
    @State private var selectedBrand = [Brand]()
    var body: some View {
        List {
            ForEach(self.searchStore.searchStore.brands, id: \.self) { item in
                MultipleSelectionRow(title: item.brand, isSelected: self.selectedBrand.contains(item)) {
                    if self.selectedBrand.contains(item) {
                        self.selectedBrand.removeAll(where: { $0 == item })
                    }
                    else {
                        self.selectedBrand.append(item)
                    }
                }
            }.onAppear{
                searchStore.fetchSearch()
                sleep(1)
            }
        }
        
    }
}
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
        BrandListView().environmentObject(SearchStore())
    }
}
