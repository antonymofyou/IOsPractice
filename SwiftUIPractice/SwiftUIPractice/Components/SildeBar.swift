//
//  SildeBar.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 08.07.2024.
//
import SwiftUI

struct SlideBar: View {
    @State private var isBarExpanded = false

    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 10) {
                Button(action: {

                }) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text("Русский язык")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)

                Button(action: {

                }) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text("Русский язык")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)

                Button(action: {

                }) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text("Русский язык")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)

                Button(action: {

                }) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text("Русский язык")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)

                Button(action: {

                }) {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text("Русский язык")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: isBarExpanded ? 90 : 0, maxHeight: .infinity)
            .clipped()
            .background(Color.gray)
            .animation(.default.speed(1), value: isBarExpanded)

            RoundedRectangle(cornerRadius: isBarExpanded ? 0 : 10, style: .continuous)
                .fill(Color.gray)
                .frame(maxWidth: 22, maxHeight: isBarExpanded ?  .infinity :  120)
                .offset(x: -6)
                .overlay(alignment: .leading) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .rotationEffect(.degrees(isBarExpanded ? 180 : 0))
                        .animation(.default.speed(2), value: isBarExpanded)
                        .foregroundColor(.white)
                }
        }
        .gesture(DragGesture()
            .onEnded { value in
                if value.translation.width > 0 {
                    isBarExpanded = true
                } else {
                    isBarExpanded = false
                }
            }
        )
        .animation(.default, value: isBarExpanded)
        .onTapGesture {
            isBarExpanded = false
        }
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SlideBar()
}
