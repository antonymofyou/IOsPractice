//
//  DraggableResizableView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

struct DraggableResizableView: View {
    var shape: CanvasElementModel
    @State var rotation: Angle
    @State private var lastRotation: Angle = .zero
    @State private var position: CGSize = .zero
    @State private var lastPosition: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    var isEditing: Bool

    var body: some View {
        ZStack {
            switch shape.type {
            case "rectangle":
                RectangleView(rotation: $rotation, shape: shape, scale: scale)
            case "image":
                ImageView(rotation: $rotation, shape: shape, scale: scale)
            case "arrow":
                ArrowView(rotation: $rotation, shape: shape, scale: scale)
            default:
                EmptyView()
            }
        }
        .scaleEffect(scale)
        .offset(position)
        .gesture(
            isEditing ? nil : DragGesture()
                .onChanged { value in
                    position.width = lastPosition.width + value.translation.width
                    position.height = lastPosition.height + value.translation.height
                    print(position)
                }
                .onEnded { value in
                    lastPosition = position
                }
        )
        .gesture(
            isEditing ? nil : SimultaneousGesture (
                MagnificationGesture()
                    .onChanged { value in
                        self.scale = value
                    },
                RotationGesture()
                    .onChanged { value in
                        rotation = lastRotation + value
                    }
                    .onEnded { value in
                        lastRotation = rotation
                    }
            )
        )
    }
}
