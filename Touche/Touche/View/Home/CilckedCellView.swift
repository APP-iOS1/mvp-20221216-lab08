//
//  CilckedCell.swift
//  Touche
//
//  Created by  장종환 on 2022/12/21.
//

import SwiftUI

struct ClickedCellView: View {
    var clicked: Clicked
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: String(clicked.imageUrl ?? "")),
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}

struct ClickedCellView_Previews: PreviewProvider {
    @State static var clicked = ClickedStore()

    static var previews: some View {
        ClickedCellView(clicked: Clicked(id: "", imageUrl: ""))
    }
}
