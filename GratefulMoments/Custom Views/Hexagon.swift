//
//  Hexagon.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/18.
//

import SwiftUI

struct Hexagon<Content: View>: View {
    private let borderWidth = 2.0
    var borderColor: Color = .ember
    var layout: HexagonLayout = .standard
    var moment: Moment? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            if let background = moment?.image {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFill()
            }
            
            content()
                .frame(width: layout.size, height: layout.size)
        }
        .mask {
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size - borderWidth, height: layout.size - borderWidth)
        }
        .background {
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size, height: layout.size)
                .foregroundStyle(borderColor)
        }
        .frame(width: layout.size, height: layout.size)
    }
}

#Preview {
    Hexagon(moment: Moment.imageSample) {
        Text(Moment.imageSample.title)
            .foregroundStyle(Color.white)
    }
    .sampleDataContainer()
}
