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

    var body: some View {
        if let imageName = shape.image {
            Image(imageName)
                .resizable()
                .rotationEffect(rotation)
                .aspectRatio(contentMode: .fit)
                .frame(width: shape.width * scale, height: shape.height * scale)
                .position(x: shape.x, y: shape.y)

        } else {
            Image("arrow")
                .resizable()
                .rotationEffect(rotation)
                .aspectRatio(contentMode: .fill)
                .frame(width: shape.width * scale, height: shape.height * scale)
                .position(x: shape.x, y: shape.y)
        }
    }
}
