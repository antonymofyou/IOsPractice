//
//  ArrowView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

struct ArrowView: View {
    @Binding var rotation: Angle
    var shape: CanvasElementModel
    var scale: CGFloat

    var body: some View {
        let arrowPath = Path { path in
            let arrowSize: CGFloat = 20 * scale
            let arrowWidth: CGFloat = shape.width * scale

            let arrowHeadX = shape.x + arrowWidth * cos(rotation.radians)
            let arrowHeadY = shape.y + arrowWidth * sin(rotation.radians)

            path.move(to: CGPoint(x: shape.x, y: shape.y))
            path.addLine(to: CGPoint(x: arrowHeadX, y: arrowHeadY))

            let angle = rotation.radians - .pi / 6
            let arrowEndX = arrowHeadX - arrowSize * cos(angle)
            let arrowEndY = arrowHeadY - arrowSize * sin(angle)

            path.move(to: CGPoint(x: arrowHeadX, y: arrowHeadY))
            path.addLine(to: CGPoint(x: arrowEndX, y: arrowEndY))

            let angle2 = rotation.radians + .pi / 6
            let arrowEndX2 = arrowHeadX - arrowSize * cos(angle2)
            let arrowEndY2 = arrowHeadY - arrowSize * sin(angle2)

            path.move(to: CGPoint(x: arrowHeadX, y: arrowHeadY))
            path.addLine(to: CGPoint(x: arrowEndX2, y: arrowEndY2))
        }

        return arrowPath
            .stroke(style: StrokeStyle(lineWidth: (shape.borderWidth ?? 10) * scale, lineCap: .round, lineJoin: .round))
            .foregroundColor(Color(hex: shape.borderColor ?? "#000000"))
    }
}
