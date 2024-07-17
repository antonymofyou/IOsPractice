//
//  ImageView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

struct ImageView: View {
    @Binding var rotation: Angle
    var shape: CanvasElementModel
    var scale: CGFloat
    var image: UIImage?
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .rotationEffect(rotation)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: shape.cornerRadius ?? 0))
                    .frame(width: shape.width * scale, height: shape.height * scale)
                    .position(x: shape.x, y: shape.y)
            }
            if let text = shape.text?.first {
                TextView(shape: shape, scale: scale)
                    .rotationEffect(rotation)
                    .frame(width: shape.width * scale, height: shape.height * scale)
                    .position(x: shape.x, y: shape.y)
            }
        }
    }
}
