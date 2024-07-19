//
//  CanvasView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

struct CanvasView: View {
    @StateObject var viewModel: CanvasViewModel = CanvasViewModel()
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
                ForEach(viewModel.elementsArray) { shape in
                    DraggableResizableView(rotation: Angle(degrees: shape.rotation ?? 0.0), shape: shape, isEditing: isEditing, image:  shape.imageId != nil ? viewModel.imagesDict[shape.imageId!] : nil)
                        .zIndex(shape.zIndex ?? 0.0)
                        .offset(dragOffset)
                        .allowsHitTesting(!isEditing)
                }
                .scaleEffect(scale)
                .offset(position)
            }
            .frame(width: UIApplication.shared.windows.first?.frame.width, height:  UIApplication.shared.windows.first?.frame.height)
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
    let jsonData = """
    {
        "imageDictionary": {},
        "shapes": [
            {
                "id": 1,
                "type": "rectangle",
                "x": 170,
                "y": 100,
                "width": 200,
                "height": 100,
                "color": "#FF5733",
                "borderColor": "#C70039",
                "zIndex": 0.5,
                "cornerRadius": 20,
                "borderWidth": 5,
                "rotation":90
            },
            {
                "id": 2,
                "type": "image",
                "x": 200,
                "y": 600,
                "width": 150,
                "height": 150,
                "imageId": "1",
                "zIndex": 0.7,
                "cornerRadius": 40
            },
            {
                "id": 3,
                "type": "arrow",
                "x": 200,
                "y": 200,
                "width": 250,
                "height": 150,
                "borderColor": "#C70039",
                "zIndex": 0.2,
                "rotation":110
            },
            {
                "id": 4,
                "type": "rectangle",
                "x": 170,
                "y": 100,
                "width": 200,
                "height": 100,
                "color": "#FF5733",
                "borderColor": "#C70039",
                "zIndex": 0.5,
                "textVerticalAlignment": "top",
                "text": [
                    {
                        "alignment": "left",
                        "text": [
                            {
                                "text": "Hello",
                                "type": "bold",
                                "fontSize": 24,
                                "fontColor": "#333333"
                            },
                            {
                                "text": " This is a test text.",
                                "fontSize": 18,
                                "fontColor": "#333333"
                            }
                        ]
                    },
                    {
                        "alignment": "right",
                        "text": [
                            {
                                "text": "Hello",
                                "type": "bold",
                                "fontSize": 24,
                                "fontColor": "#333333"
                            },
                            {
                                "text": " This is a test text.",
                                "fontSize": 18,
                                "fontColor": "#333333"
                            }
                        ]
                    }

                ],
                "borderWidth": 5
            }
        ]
    }
""".data(using: .utf8) ?? nil
    //Preview
    var viewModel: CanvasViewModel = CanvasViewModel()
    viewModel.convertJsonToCanvasData(jsonData: jsonData ?? Data())
    return CanvasView(viewModel: viewModel)
}
