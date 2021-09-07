//
//  Home.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

private let strokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)
private let shoulderRatio: CGFloat = 0.65
private let arrowLayoutConfig = LayoutGuideConfig.grid(columns: [0, shoulderRatio, 1], rows: 3)

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var g = arrowLayoutConfig.layout(in: rect)
        
        path.move(g[0, 1])
        path.line(g[1, 1])
        path.line(g[1, 0])
        path.line(g.trailing)
        path.line(g[1, 3])
        path.line(g[1, 2])
        path.line(g[0, 2])
        
        path.closeSubpath()
        
        return path
    }
}


struct GridLayoutGuides_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Arrow()
                .stroke(style: strokeStyle)
                .layoutGuide(arrowLayoutConfig)
        }
        .frame(width: 200, height: 100)
        .padding()
        .previewSizeThatFits()
//        .showLayoutGuides(true)
    }
}

