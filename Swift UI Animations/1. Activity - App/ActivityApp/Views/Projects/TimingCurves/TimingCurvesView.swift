//
//  TimingCurves.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

// MARK: - Constants
private let numDots = 5
private let dotSize: CGFloat = 8
private let duration: Double = 2
private let maxOffset = UIScreen.mainWidthScaled(0.5) + dotSize

// MARK: - Coordinates
private let gridCoordName = "grid-coord"
private let controlPointSize: CGFloat = 10

struct TimingCurvesView: View {
    @State private var cp0 = CGPoint(x: 0.4, y: 0.4)
    @State private var cp1 = CGPoint(x: 0.6, y: 0.6)
    
    @State private var animating = [Bool](repeating: false, count: numDots)
    
    var body: some View {
        let curveEditor = TimingCurve(cp0: $cp0, cp1: $cp1)
        
        return ZStack {
            Color.black.opacity(0.93)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomText("Inlook", 80, .white)
                ZStack {
                    ForEach(0..<numDots) { index in
                        Circle()
                            .fillColor(.white)
                            .frame(dotSize)
                            .xOffset(self.animating[index] ? maxOffset : -maxOffset)
                            .onAppear() {
                                after(Double(index) * 0.2) {
                                    every(duration) { timer in
                                        self.animating[index] = false
                                        withAnimation(curveEditor.generate(duration: duration)) {
                                            self.animating[index] = true
                                        }
                                    }
                                }
                            }
                    }
                }
                curveEditor.asView(size: 200)
                    .yOffset(100)
            }
        }
    }
}

private struct TimingCurve {
    @Binding var cp0: CGPoint
    @Binding var cp1: CGPoint
    
    func asView(size: CGFloat) -> some View {
        let cp0Scaled = scaleFromUnitPoint(cp0, to: size)
        let cp1Scaled = scaleFromUnitPoint(cp1, to: size)
        
        return VStack {
            ZStack {
                CurveShape(cp0Scaled: cp0Scaled, cp1Scaled: cp1Scaled)
                    .stroke(Color.white, lineWidth: 2)
                    .layoutGuide(.grid(columns: 10, rows: 10), color: .white)
                    .showLayoutGuides(true)
                
                BodyView(cp0Scaled: cp0Scaled, cp1Scaled: cp1Scaled, cp0: self.$cp0, cp1: self.$cp1)
            } //: ZSTACK
            .coordinateSpace(name: gridCoordName)
            .frame(size)
            
            textForPoint(self.cp0, name: "CP0")
            textForPoint(self.cp1, name: "CP1")
        } //: VSTACK
    }
    
    
    func generate(duration: Double = 0.35) -> Animation {
        Animation.timingCurve(cp0.x.asDouble, cp0.y.asDouble, cp1.x.asDouble, cp1.y.asDouble, duration: duration)
    }
}

private struct BodyView: View {
    let cp0Scaled: CGPoint
    let cp1Scaled: CGPoint
    
    @Binding var cp0: CGPoint
    @Binding var cp1: CGPoint
    
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            ZStack {
                Frame(controlPointSize, .green)
                    .clipCircleWithStroke(.black, lineWidth: 2)
                    .offsetToPosition(self.cp0Scaled, in: gridCoordName)
                    .gesture(DragGesture(coordinateSpace: .named(gridCoordName)).onChanged({ (value) in
                        self.cp0 = scaleToUnitPoint(value.location, from: geo.width)
                        self.cp1 = CGPoint(1 - self.cp0.x, 1 - self.cp0.y)
                    }))
                
                Frame(controlPointSize, .yellow)
                    .clipCircleWithStroke(.black, lineWidth: 2)
                    .offsetToPosition(self.cp1Scaled, in: gridCoordName)
                    .gesture(DragGesture(coordinateSpace: .named(gridCoordName)).onChanged({ (value) in
                        self.cp1 = scaleToUnitPoint(value.location, from: geo.width)
                        self.cp0 = CGPoint(1 - self.cp1.x, 1 - self.cp1.y)
                    }))
            } //: ZSTACK
        } //: GEOMETRY_READER
    }
}


private struct CurveShape: Shape {
    let cp0Scaled: CGPoint
    let cp1Scaled: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(rect.bottomLeading)
        path.curve(rect.topTrailing, cp1: cp0Scaled, cp2: cp1Scaled, showControlPoints: true)
        
        return path
    }
}

// MARK: - Utilities
private func scaleFromUnitPoint(_ point: CGPoint, to size: CGFloat) -> CGPoint {
    let invertedPoint = invertY(point)
    let scaledPoint = invertedPoint.scaled(size)
    return scaledPoint
}

private func scaleToUnitPoint(_ point: CGPoint, from size: CGFloat) -> CGPoint {
    let scaledPoint = point.scaled(1 / size)
    let invertedPoint = invertY(scaledPoint)
    return invertedPoint
}

// invert y-axis point (from swift ui coordinate system => human coordinate system)
private func invertY(_ unitPoint: CGPoint) -> CGPoint {
    CGPoint(unitPoint.x, 1 - unitPoint.y)
}

private func textForPoint(_ point: CGPoint, name: String) -> Text {
    Text("\(name): (\(point.x, specifier: "%.2f"), \(point.y, specifier: "%.2f"))")
        .headlineFont(.white)
}

struct TimingCurvesView_Previews: PreviewProvider {
    static var previews: some View {
        TimingCurvesView()
    }
}
