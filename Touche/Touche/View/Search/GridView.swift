//
//  GridViewTest.swift
//  Touche_2
//
//  Created by TAEHYOUNG KIM on 2022/12/01.
//

import SwiftUI


struct GridView: View {
    
    @EnvironmentObject var searchStore: SearchStore
    @State private var elementsSize: [Brand: CGSize] = [:]
    @State private var availableWidth: CGFloat = 0
//    @Binding var selectedBrand: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
                ForEach(computeRows(), id: \.self) { rowElements in
                    HStack {
                        ForEach(Array(zip(rowElements.indices, rowElements)), id: \.0) { index, element in
                            Button {
                                searchStore.searchStore.brands[index].isSelected = false
                            } label: {
                                if element.isSelected {
                                    HStack {
                                        Text(element.brand)
                                            .foregroundColor(.black)
                                        Image(systemName: "xmark")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.bottom, 5)
//                                    .overlay(Capsule(style: .continuous)
//                                        .stroke(Color.black))
                                     
                                }
                            }
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                        }
                    }
                }
            }
    }
    func computeRows() -> [[Brand]] {
        var rows: [[Brand]] = [[]]
        var currentRow = 0
        var remainingWidth: CGFloat = 300
        
        for element in searchStore.searchStore.brands {
            let elementSize = elementsSize[element, default: CGSize(width: 300, height: 1)]
            
            if remainingWidth - elementSize.width >= 0 {
                rows[currentRow].append(element)
            } else {
                // start a new row
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = 300
            }
            
            remainingWidth = remainingWidth - elementSize.width
        }
        
        return rows
    }
}



extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
