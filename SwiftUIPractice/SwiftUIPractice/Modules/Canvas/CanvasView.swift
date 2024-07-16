//
//  CanvasView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

struct CanvasView: View {

    var viewModel: CanvasViewModel = CanvasViewModel()
    @State private var isEditing: Bool = false
    @State private var dragOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var position: CGSize = .zero
    @State private var lastPosition: CGSize = .zero

    var body: some View {
        ZStack {
            Color.white
            ZStack {
                ForEach(viewModel.getCanvasData()) { shape in
                    DraggableResizableView(shape: shape, rotation: Angle(degrees: shape.rotation ?? 0.0), isEditing: isEditing, image:  shape.imageId != nil ? viewModel.imagesDict[shape.imageId!] : nil)
                        .zIndex(shape.zIndex ?? 0.0)
                        .offset(dragOffset)
                        .allowsHitTesting(!isEditing)

                }
                .scaleEffect(scale)
                .offset(position)
            }
            .frame(width: 414, height: 842)
        }
        .ignoresSafeArea()
        .gesture(

            !isEditing ? nil : DragGesture()
                .onChanged { value in
                    position.width = lastPosition.width + value.translation.width
                    position.height = lastPosition.height + value.translation.height
                }
                .onEnded { value in
                    lastPosition = position
                }
        )
        .simultaneousGesture(
            !isEditing ? nil : MagnificationGesture()
                .onChanged { value in
                    scale = lastScale * value
                }
                .onEnded { _ in
                    lastScale = scale
                }
        )
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                isEditing.toggle()
            }) {
                Image(isEditing ? .editing : .notEditing)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(30)
        }
    }
}

#Preview {
    var shapes: [CanvasElementModel]
    var viewModel: CanvasViewModel = CanvasViewModel()
    return CanvasView()
}
