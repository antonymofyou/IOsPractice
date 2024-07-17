//
//  RectangleView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//


import SwiftUI
struct RectangleView: View {
    @Binding var rotation: Angle
    var shape: CanvasElementModel
    var scale: CGFloat

    var body: some View {
          ZStack {
              RoundedRectangle(cornerRadius: shape.cornerRadius ?? 0.0)
                  .fill(Color(hex: shape.color ?? "#ffffff"))
                  .overlay(
                      RoundedRectangle(cornerRadius: shape.cornerRadius ?? 0.0)
                          .stroke(Color(hex: shape.borderColor ?? "#ffffff"), lineWidth: (shape.borderWidth ?? 0.0) * scale)
                  )
                  .rotationEffect(rotation)
                  .frame(width: shape.width * scale, height: shape.height * scale)
                  .position(x: shape.x, y: shape.y)
                  .overlay {
                      if let text = shape.text?.first {
                          TextView(shape: shape, scale: scale)
                              .rotationEffect(rotation)
                              .frame(width: shape.width * scale, height: shape.height * scale, alignment: Alignment.from(string: shape.alignment ?? "center"))
                              .position(x: shape.x, y: shape.y)
                      }
                  }
          }
      }
}


