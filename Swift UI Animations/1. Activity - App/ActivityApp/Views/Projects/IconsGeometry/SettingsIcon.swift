//
//  Testing.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 21/2/21.
//

import SwiftUI
import PureSwiftUI

// MARK: - Colors
private let startColor = Color.rgb8(228, 229, 231)
private let endColor = Color.rgb8(139, 143, 150)
private let gradient = LinearGradient([startColor, endColor], angle: .bottom)

// MARK: - Constants
private let numTeeth = 54
private let segmentsPerTooth = 20
private let numSegments = numTeeth * segmentsPerTooth

// MARK: - LayoutGuides
// Teeth surrounding
private let teethLayoutGuide = LayoutGuideConfig.polar(rings: [0.885, 1], segments: numSegments)
// Inner spokes
private let halfSpokeWidth: CGFloat = 0.025
private let spokePolarConfig = LayoutGuideConfig.polar(rings: [0.78], segments: 60)
private let spokeGridConfig = LayoutGuideConfig.grid(
    columns: [0.5 - halfSpokeWidth, 0.5 + halfSpokeWidth], rows: [0.1, 0.25, 0.46])

private let turnDegrees = (360 / 3)
private let defaultAngle = -30.5.degrees

private struct SettingsIcon: View {
    @State private var isAnimating = false
    
    var body: some View {
        let debug = false
        let primaryCogScale: CGFloat = 0.8
        
        ZStack {
            Color.black.opacity(0.9)
            
            ZStack {
                Color(white: 0.183)
                    .clipShape(Circle())
                    .opacityIf(debug, 0)
                
                Shroud()
                    .debugStyle(debug: debug)
                
                Cog(scale: 0.3, debug: debug)
                    .rotateIfNot(debug, -defaultAngle)
                    .rotateIf(isAnimating, -720.degrees)
                    .debugStyle(debug: debug)
                
                Cog(inner: true, scale: 0.53, debug: debug)
                    .rotateIfNot(debug, defaultAngle)
                    .rotateIfNot(isAnimating, 360.degrees)
                    .debugStyle(debug: debug)
                
                Cog(scale: primaryCogScale, debug: debug)
                    .rotateIfNot(debug, defaultAngle)
                    .rotateIf(isAnimating, 360.degrees)
                    .debugStyle(debug: debug)
//                     .layoutGuide(teethLayoutGuide, color: .green)
                    .layoutGuide(spokePolarConfig.scaled(primaryCogScale), color: .blue, lineWidth: 1)
                    .layoutGuide(spokeGridConfig.scaled(primaryCogScale), color: .red, lineWidth: 1)
                    .layoutGuide(spokeGridConfig.scaled(primaryCogScale).rotated(turnDegrees.degrees), color: .red, lineWidth: 1)
            } //: ZSTACK
            .shadowIfNot(debug, color: .black, radius: 10)
            .showLayoutGuides(debug)
            .frame(400)
        } //: ZSTACK
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) { self.isAnimating = true }
        }
    }
}

private struct Shroud: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.roundedRect(rect, cornerSize: rect.sizeScaled(0.122))
        path.circle(rect.center, diameter: rect.sizeScaled(0.87).width)
        
        return path
    }
}

private struct Cog: Shape {
    var inner = false
    let scale: CGFloat
    var debug: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var pt = teethLayoutGuide.scaled(scale).layout(in: rect)
        
        let rotationDelta = pt.angleTo(0, segmentsPerTooth)
        pt = pt.rotated(-pt.angleTo(1, segmentsPerTooth / 4))
        
        path.move(pt[0, 0])
        for tooth in 0..<numTeeth {
            let localPt = pt.rotated(rotationDelta * tooth)
            path.line(localPt[1, 4])
            path.line(localPt[1, 6])
            path.line(localPt[0, segmentsPerTooth / 2])
            path.line(localPt[0, segmentsPerTooth])
        }
        
        path.closeSubpath()
        
        if inner {
            path.circle(rect.center, diameter: rect.widthScaled(0.72 * scale))
        } else {
            var p = spokePolarConfig.scaled(scale).layout(in: rect)
            var g = spokeGridConfig.scaled(scale).layout(in: rect)
            
            for _ in 0..<3 {
                path.move(g[1, 2])
                path.line(g[1, 1])
                path.curve(p[0, 3], cp1: g[1, 0], cp2: p[0, 2], showControlPoints: debug)
                path.arc(rect.center, radius: p.radiusTo(0, 0), startAngle: p.angleTo(0, 3), endAngle: p.angleTo(0, 17))
            
                g = g.rotated(turnDegrees.degrees)
                path.curve(g[0, 1], cp1: p[0, 18], cp2: g[0, 0], showControlPoints: debug)
                path.line(g[0, 2])
                path.closeSubpath()

                p = p.rotated(turnDegrees.degrees)
            }
            
            path.circle(rect.center, diameter: rect.widthScaled(0.04 * scale))
        }
        
        return path
    }
}

private extension Shape {
    @ViewBuilder func debugStyle(debug: Bool) -> some View {
        if debug {
            let strokeStyle = StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round)
            stroke(Color.orange, style: strokeStyle)
        } else {
            let fillStyle = FillStyle(eoFill: true)
            fill(gradient, style: fillStyle)
        }
    }
}

struct SettingsIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIcon()
    }
}
