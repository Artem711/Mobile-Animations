//
//  SquishyToggle.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 21/2/21.
//

import SwiftUI
import PureSwiftUI

// MARK: - Constants

// MARK: - Layout Guides
private let frameLayoutConfig = LayoutGuideConfig.grid(columns: [0.25, 0.4, 0.6, 0.75], rows: 2)

struct SquishyToggle: View {
    @State private var isEnabled = false
    
    var body: some View {
        let debug = false
        
        GeometryReader(content: { geometry in
            let size = calculateSize(from: geometry)
            ZStack {
                ToggleFrame(isEnabled, debug: debug)
                    .styling(color: .green)
                    .layoutGuide(frameLayoutConfig, color: .green, lineWidth: 2)
                    // animation = determines the attitude of the animation of `animatable data` of the shape
                    .animation(.linear(duration: 1))
                
                ToggleButton()
                    .frame(size.heightScaled(0.9))
                    .xOffset(self.isEnabled ? size.halfHeight : -size.halfHeight)
                    .animation(.easeInOut(duration: 1))
            } //: ZSTACK
            .frame(size) // .frame(width: size.width, height: size.height)
            .borderIf(debug, Color.gray.opacity(0.2))
            .contentShape(Capsule())
            .onTapGesture { self.isEnabled.toggle() }
            .greedyFrame() // .frame(width: .infinity, height: .infinity)
        }) //: GEOMETRY_READER
        .showLayoutGuides(debug)
    }
    
    // MARK: - Calculate size of the shape (we want (WIDTH) = (2 x HEIGHT))
    private func calculateSize(from geo: GeometryProxy) -> CGSize {
        let doubleHeight = geo.heightScaled(2)
        if geo.width < doubleHeight {
            return CGSize(width: geo.width, height: geo.halfWidth)
        } else {
            return CGSize(width: doubleHeight, height: geo.height)
        }
    }
}

private struct ToggleFrame: Shape {
    var animatableData: CGFloat
    private let debug: Bool
    
    init(_ isEnabled: Bool,  debug: Bool = false) {
        self.animatableData = isEnabled ? 1 : 0
        self.debug = debug
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = frameLayoutConfig.layout(in: rect)
        
        let maxCurveYOffset = rect.heightScaled(0.18)
        let offsetLayoutGuide = LayoutGuide.polar(
            .rect(.zero, .square(maxCurveYOffset)), rings: 1, segments: 1)
            // CGRect(origin: .zero, size: CGSize(width: x, height: y))
            .rotated(360.degrees, factor: animatableData) // based on `animatableData` we interpolate our shape
        
        let yCurveOffset = offsetLayoutGuide.bottom.y
        let arcRadius = rect.height / 2
        
        path.move(g[0, 0])
        path.curve(
            rect.top.yOffset(yCurveOffset),
            cp1: g[1, 0], cp2: g[1, 0].yOffset(yCurveOffset),
            showControlPoints: debug)
        
        path.curve(g[3, 0], cp1: g[2, 0].yOffset(yCurveOffset), cp2: g[2, 0], showControlPoints: debug)
        path.arc(
            g[3, 1],
            radius: arcRadius,
            startAngle: .top,
            endAngle: .bottom)

        path.curve(
            rect.bottom.yOffset(-yCurveOffset),
            cp1: g[2, 2], cp2: g[2, 2].yOffset(-yCurveOffset),
            showControlPoints: debug)

        path.curve(
            g[0, 2],
            cp1: g[1, 2].yOffset(-yCurveOffset),
            cp2: g[1, 2],
            showControlPoints: debug)
        path.arc(
            g[0, 1],
            radius: arcRadius,
            startAngle: .bottom,
            endAngle: .top)
        
        return path
    }
    
    @ViewBuilder func styling(color: Color) -> some View {
        if self.debug {
            strokeColor(.black, lineWidth: 2)
        } else {
            fill(color)
        }
    }
}

private struct ToggleButton: View {
    var body: some View {
        let outerGradient = LinearGradient([Color.white(0.45), Color.white(0.95)], to: .topLeading)
        
        GeometryReader { (geometry: GeometryProxy) in
            let innerGradient = RadialGradient([Color.white(0.9), Color.white(0.3)], center: .bottomTrailing,
                                               from: geometry.widthScaled(0.2), to: geometry.widthScaled(1.5))
            ZStack {
                Circle()
                    .fill(outerGradient)
                Circle()
                    .inset(by: geometry.widthScaled(0.1))
                    .fill(innerGradient)
            }
            .drawingGroup()
            .shadow(5)
        }
    }
}

struct SquishyToggle_Previews: PreviewProvider {
    static var previews: some View {
        SquishyToggle()
            .frame(400)
    }
}
