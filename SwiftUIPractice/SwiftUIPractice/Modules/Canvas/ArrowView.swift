//
//  ArrowView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

import SwiftUI

struct ArrowView: View {
    @Binding var rotation: Angle
    var shape: CanvasElementModel
    var scale: CGFloat

    var body: some View {
        let arrowPath = Path { path in

            path.move(to: CGPoint(x: shape.x, y: shape.y))
            path.addLine(to: CGPoint(x: shape.x_2 ?? shape.x + shape.width, y: shape.y_2 ?? shape.y))

            let arrowSize: CGFloat = 20
            let angle = atan2((shape.y_2 ?? shape.y) - shape.y, (shape.x_2 ?? shape.x + shape.width) - shape.x)
            path.addLine(to: CGPoint(
                x: (shape.x_2 ?? shape.x + shape.width) - arrowSize * cos(angle - .pi / 3),
                y: (shape.y_2 ?? shape.y) - arrowSize * sin(angle - .pi / 6)
            ))
            path.move(to: CGPoint(x: shape.x_2 ?? shape.x + shape.width, y: shape.y_2 ?? shape.y))
            path.addLine(to: CGPoint(
                x: (shape.x_2 ?? shape.x + shape.width) - arrowSize * cos(angle + .pi / 3),
                y: (shape.y_2 ?? shape.y) - arrowSize * sin(angle + .pi / 6)
            ))
        }

        return arrowPath
            .stroke(style: StrokeStyle(lineWidth: (shape.borderWidth ?? 10) * scale, lineCap: .round, lineJoin: .round))
            .foregroundColor(Color(hex: shape.borderColor ?? "#000000"))
            .rotationEffect(rotation)
//            .position(x: UIScreen.main.bounds.width / 2 + position.width, y: UIScreen.main.bounds.height / 2 + position.height)
    }
}
