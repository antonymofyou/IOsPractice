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
                    .frame(width: shape.width * scale, height: shape.height * scale)
                    .position(x: shape.x, y: shape.y)
            }
            if let borderWidth = shape.borderWidth, let borderColor = shape.borderColor {
                RoundedRectangle(cornerRadius: shape.cornerRadius ?? 0, style: .continuous)
                    .stroke(Color(hex: borderColor), lineWidth: borderWidth * scale)
                    .frame(width: shape.width * scale, height: shape.height * scale)
                    .position(x: shape.x, y: shape.y)

                    .rotationEffect(rotation)

            }
            if let text = shape.text?.first {
                Text(text.text)
                    .font(Font.system(size: text.fontSize ?? 12))
                    .foregroundColor(Color(hex: text.fontColor ?? "black"))
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .rotationEffect(rotation)
                    .frame(width: shape.width * scale, height: shape.height * scale)
                    .position(x: shape.x, y: shape.y)
            }
        }
    }
}
