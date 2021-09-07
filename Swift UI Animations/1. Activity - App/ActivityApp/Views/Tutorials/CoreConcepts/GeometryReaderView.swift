//
//  GeometryReaderView.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 20/2/21.
//

import SwiftUI

private let size: CGFloat = 200
private let numLayers = 20
private let stepSize = 25

struct GeometryReaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            ForEach(0..<numLayers) { index in
                PyramidLayer()
                    .rotateIf(self.isAnimating, 90.degrees)
                    .shadow(5)
                    .frame(self.sizeForIndex(index))
                    .animation(Animation
                                .easeInOut(duration: 2)
                                .repeatForever()
                                .delay(self.delayForIndex(index)))
            } //: FOR_EACH
            .onAppear() { self.isAnimating = true }
        } //: ZSTACK
        .padding(100)
        .drawingGroup()
    }
    
    private func sizeForIndex(_ index: Int) -> CGFloat {
        CGFloat((numLayers - index) * stepSize)
    }
    
    private func delayForIndex(_ index: Int) -> Double {
        Double(numLayers - index) * 0.2
    }
}

private let gradient = LinearGradient([Color.red, Color.yellow], angle: .bottomTrailing)
private struct PyramidLayer: View {
    var body: some View {
        GeometryReader { (geo: GeometryProxy) in
            RoundedRectangle(geo.widthScaled(0.2))
                .fill(gradient)
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
