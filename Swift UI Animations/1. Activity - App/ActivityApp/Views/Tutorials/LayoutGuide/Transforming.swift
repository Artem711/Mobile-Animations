//
//  Transforming.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

private let numberOfSegments = 3
private let strokeStyle = StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)

private let gridLayoutGuide = LayoutGuideConfig.grid(columns: 3, rows: 3)
private let polarLayoutGuide = LayoutGuideConfig.polar(rings: 1, segments: numberOfSegments)

struct Transforming: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 50) {
            Group {
                BadgeShape(isAnimating: isAnimating)
                    .stroke(Color.white, style: strokeStyle)
                    .layoutGuide(polarLayoutGuide)
            }
            .frame(200)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 2)) { self.isAnimating.toggle() }
        }
    }
}

struct BadgeShape: Shape {
    var animatableData: CGFloat
    
    init(isAnimating: Bool) {
        self.animatableData = isAnimating ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var g = polarLayoutGuide.layout(in: rect)
            .rotated(from: -360.degrees, to: 360.degrees, factor: animatableData)
            .scaled(1 / .pi)
            .xOffset(from: -rect.halfWidth, to: rect.halfWidth, factor: animatableData)
        
        let transformedHeight = g.bottom.radiusTo(g.top)
        
        g = g
            .yOffset(-transformedHeight * 0.5)
        
        path.line(from: rect.leading, to: rect.trailing)
        path.ellipse(g.center, .square(transformedHeight), anchor: .center)
        
        for segment in 0..<g.yCount {
            path.line(from: g.center, to: g[1, segment])
        }
        
        return path
    }
}

struct Transforming_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(white: 0.1)
                .edgesIgnoringSafeArea(.all)
            
            Transforming()
                .showLayoutGuides(true)
        }
    }
}

 
