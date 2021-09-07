//
//  Patterns.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

private let strokeStyle = StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
private let gridLayoutConfig = LayoutGuideConfig.grid(columns: 3, rows: 3)

struct Patterns: View {
    @State var isAnimated = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                GridBadge(isAnimated: isAnimated)
                    .stroke(Color.white, style: strokeStyle)
                    .layoutGuide(gridLayoutConfig)
                    .frame(240)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 2)) { isAnimated.toggle() }
            }
        }
    }
}

struct GridBadge: Shape {
    var animatableData: CGFloat
    
    init(isAnimated: Bool) {
        self.animatableData = isAnimated ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var g = gridLayoutConfig.layout(in: rect)
            .scaled(1 / .pi)
            .rotated(360.degrees, factor: animatableData)
        
        for corner in 0..<4 {
            let lg = g.rotated(90.degrees * corner)
            
            if corner == 0 { path.move(g.top) }
            path.line(lg[2, 0])
            path.line(lg[3, 0].to(lg[2, 1], animatableData))
            path.line(lg[3, 1])
            path.line(lg.trailing)
        }
        
        return path
    }
}

struct Patterns_Previews: PreviewProvider {
    static var previews: some View {
        Patterns()
            .showLayoutGuides(true)
    }
}
