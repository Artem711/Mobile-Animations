//
//  BezierCurves.swift
//  ActivityApp
//
//  Created by Артём Мошнин on 19/2/21.
//

import SwiftUI
import PureSwiftUI

private let heartColor = Color(red: 255 / 255, green: 40 / 255, blue: 48 / 255)


private let heartLayoutConfig = LayoutGuideConfig.grid(columns: 8, rows: 10)

struct BezierCurves: View {
    var body: some View {
        VStack {
            Heart()
                .fill(heartColor)
                .frame(200)
            
            ZStack {
                Image("heart")
                    .resizedToFit(200)
                
                Heart(debug: true)
                    .stroke(Color.black, lineWidth: 2)
                    .layoutGuide(heartLayoutConfig)
                    .frame(200)
            } //: ZTASCK
        } //: VSTACK
    }
}


private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)
struct Heart: Shape {
    let debug: Bool
    
    init(debug: Bool = false) {
        self.debug = debug
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let g = heartLayoutConfig.layout(in: rect)

        let p1 = g[0, 3]
        let p2 = g[g.xCount / 2, 2]
        let p3 = g[g.xCount, 3]
        let p4 = g[g.xCount / 2, g.yCount]
        
        var curves = [Curve]()
        // c1
        curves.append(Curve(p2, g[0, 0], g[3, -1]))
        // c2
        curves.append(Curve(p3, g[5, -1], g[g.xCount, 0]))
        // c3
        curves.append(Curve(p4, g[g.xCount, 5], g[5, 7]))
        // c4
        curves.append(Curve(p1, g[3, 7], g[0, 5]))
        
        path.move(p1)
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: self.debug)
        }
        
        return path
    }
}

struct BezierCurves_Previews: PreviewProvider {
    static var previews: some View {
        BezierCurves()
            .showLayoutGuides(true)
    }
}
