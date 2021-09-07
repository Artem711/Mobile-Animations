//
//  ExtensionsView.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 20/2/21.
//

import SwiftUI
import PureSwiftUI

private let gradient = LinearGradient([Color.red, Color.yellow], to: .trailing)
struct ExtensionsView: View {
    var body: some View {
        VStack {
            Circle()
                .strokeWithFill(Color.black, fill: gradient)
                .grid(3, 3)
                .shapeShadowSize()
                .grid(3, 3)
            
            Text("doksnadjsa")
                .grid(3, 1)
        }
    }
}

private extension View {
    func shapeShadowSize() -> some View {
        shadow(5)
            .frame(100)
    }
    
    func grid(_ columns: Int, _ rows: Int, spacing: CGFloat = 10) -> some View {
        VStack(spacing: spacing) {
            ForEach(0..<rows) { _ in
                HStack(spacing: spacing) {
                    ForEach(0..<columns) { _ in
                        self
                    }
                }
            }
        }
    }
}

private extension Shape {
    func strokeWithFill<SS: ShapeStyle, FS: ShapeStyle>(_ strokeContents: SS, fill: FS,  lineWidth: CGFloat = 2) -> some View {
        self.fill(gradient)
            .overlay(self.stroke(strokeContents, lineWidth: lineWidth))
    }
}

struct ExtensionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionsView()
    }
}
