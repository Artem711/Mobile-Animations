//
//  PolarLayoutGuides.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

private let numSegments = 12
private let innerRadiusRatio: CGFloat = 0.4
private let strokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)

private let starLayoutConfig = LayoutGuideConfig.polar(rings: [0, innerRadiusRatio, 1], segments: numSegments)
private let triangleLayoutConfig = LayoutGuideConfig.polar(rings: 1, segments: 3)

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var g = starLayoutConfig.layout(in: rect)
        path.move(g[2, 0])
        
        for segment in 1..<g.yCount {
            path.line(g[segment.isOdd ? 1 : 2, segment])
        }
        path.closeSubpath()
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var g = triangleLayoutConfig.layout(in: rect)
        path.move(g[1, 0])
        
        for segment in 1..<g.yCount {
            path.line(g[1, segment])
        }
        path.closeSubpath()
        
        return path
    }
}

struct PolarLayoutGuides_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Star()
                .stroke(style: strokeStyle)
                .layoutGuide(starLayoutConfig)
            
            Triangle()
                .stroke(style: strokeStyle)
                .layoutGuide(triangleLayoutConfig)
        } //: VSTACK
        .padding()
        .previewSizeThatFits()
        .showLayoutGuides(true)
    }
}
