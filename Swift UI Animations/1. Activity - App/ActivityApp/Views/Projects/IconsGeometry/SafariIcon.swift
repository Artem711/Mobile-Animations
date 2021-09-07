//
//  SafariIcon.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 21/2/21.
//

import SwiftUI
import PureSwiftUI

// MARK: - Constants
private let gradientStart = Color.rgb8(36, 199, 249)
private let gradientEnd = Color.rgb8(37, 109, 236)
private let gradient = LinearGradient([gradientStart, gradientEnd], angle: .bottom)

private let pointerColor = Color.rgb8(251, 61, 41)

// MARK: - Layout Guides
private let halfTriangleWidth: CGFloat = 0.065
private let halfTriangleTipWidth: CGFloat = 0.005

private let polarLayoutGuide = LayoutGuideConfig.polar(rings: [0, 0.83, 0.91, 1], segments: 72)
private let gridLayoutGuide = LayoutGuideConfig.grid(
    columns: [0, 0.5 - halfTriangleWidth, 0.5 - halfTriangleTipWidth, 0.5 + halfTriangleTipWidth, 0.5 + halfTriangleWidth, 1],
    rows: 2)

struct SafariIcon: View {
    @State private var isRotating = false
    
    var body: some View {
        let debug = false
        GeometryReader { (geo) in
            ZStack {
                RoundedRectangle(cornerRadius: geo.widthScaled(0.2))
                    .fill(Color.white)
                
                Circle() //: CIRCLE
                    .fill(gradient)
                    .frame(geo.widthScaled(0.87))
                
                Graduations() //: CLOCK
                    .stroke(Color.white, lineWidth: geo.widthScaled(0.01))
                    .frame(geo.widthScaled(0.8))
                    .layoutGuide(polarLayoutGuide)
                
                Group {
                    Pointer(isShadow: true)
                        .blur(geo.widthScaled(0.02))
                        .drawingGroup()
                        .blendMode(.multiply)
                    
                    Pointer()
                }
                .frame(geo.widthScaled(0.8))
                .rotate(50.degrees)
                .layoutGuide(gridLayoutGuide)
                .rotateIf(self.isRotating, 360.degrees)
                
            } //: ZSTACK
        } //: GEOMETRY_READER
        .showLayoutGuides(debug)
        .onAppear() {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.isRotating = true
            }
        }
    }
}

private struct Pointer: View {
    var isShadow = false
    
    var body: some View {
        ZStack {
        TriangleShape()
            .fill(self.isShadow ? Color.gray : pointerColor)
            
            TriangleShape()
                .fill(self.isShadow ? Color.gray : Color.white)
                .rotate(180.degrees)
        }
    }
}

private struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var g = gridLayoutGuide.layout(in: rect)
        
        path.move(g[1, 1])
        path.line(g[2, 0])
        path.line(g[3, 0])
        path.line(g[4, 1])
        return path
    }
}

private struct Graduations: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var p = polarLayoutGuide.layout(in: rect)
        
        for segment in 0..<p.yCount {
            path.line(from: p[3, segment], to: p[segment.isOdd ? 2 : 1, segment])
        }
        
        return path
    }
}

struct SafariIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach([200, 100, 50], id: \.self) { (size: CGFloat) in
                SafariIcon()
                    .frame(size)
                    .vPadding()
            }
        }
        .greedyFrame()
        .background(Color(white: 0.1))
        .ignoresSafeArea()
    }
}
