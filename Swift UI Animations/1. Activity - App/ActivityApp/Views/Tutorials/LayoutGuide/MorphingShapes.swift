//
//  MorphingShapes.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI


private let strokeStyle = StrokeStyle(lineWidth: 2, lineJoin: .round)
private let shoulderRatio: CGFloat = 0.65
private let arrowLayoutConfig = LayoutGuideConfig.grid(columns: [0, 1 - shoulderRatio, shoulderRatio, 1], rows: 3)

struct ArrowAnimated: Shape {
    private var factor: CGFloat
    
    init(isPointRight: Bool = true) {
        self.factor = isPointRight ? 0 : 1
    }
    
    var animatableData: Double {
        get { Double(factor) }
        set { factor = CGFloat(newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = arrowLayoutConfig.layout(in: rect)
        
        path.move(g[0, 1].to(g[1, 0], factor))
        path.line(g[2, 1].to(g[1, 1], factor))
        path.line(g[2, 0].to(g[3, 1], factor))
        path.line(g.trailing)
        path.line(g[2, 3].to(g[3, 2], factor))
        path.line(g[2, 2].to(g[1, 2], factor))
        path.line(g[0, 2].to(g[1, 3], factor))
        path.line(g.leading)
        
        path.closeSubpath()
        
        return path
    }
}

struct MorphingShapes_Previews: PreviewProvider {
    struct Demo: View {
        @State var isPointingRight = true
        
        var body: some View {
            VStack(spacing: 50) {
                Group {
                    ArrowAnimated(isPointRight: isPointingRight)
                        .onTapGesture { withAnimation(.easeInOut(duration: 2)) { self.isPointingRight.toggle() } }
                    ArrowAnimated()
                        .stroke(style: strokeStyle)
                        .layoutGuide(arrowLayoutConfig)
                }
                .frame(width: 200, height: 100)
            }
            
        }
    }
    
    static var previews: some View {
        Demo()
        .padding()
//        .previewSizeThatFits()
        .showLayoutGuides(true)
    }
}
