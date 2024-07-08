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
        ZStack(alignment: .leading) {
            Color.white
                .edgesIgnoringSafeArea(.all)

            HStack(spacing: 0) {
                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Button(action: {

                        }) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }

                        Button(action: {

                        }) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }

                        Button(action: {

                        }) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }

                        Button(action: {

                        }) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }

                        Button(action: {

                        }) {
                            Image(systemName: "book.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                    .frame(width: isBarExpanded ? 90 : 0, height: 400)
                    .clipped()
                    .background(Color.gray)
                    .animation(.default, value: isBarExpanded)

                    Spacer()
                }

                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.gray)
                    .frame(width: 18, height: 400)
                    .offset(x: -4)
                    .gesture(DragGesture()
                                .onChanged { value in
                                    if value.translation.width > 50 {
                                        withAnimation {
                                            isBarExpanded = true
                                        }
                                    }
                                    if value.translation.width < -50 {
                                        withAnimation {
                                            isBarExpanded = false
                                        }
                                    }
                                }
                    )
                    .overlay(
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                            .rotationEffect(.degrees(isBarExpanded ? 180 : 0))
                            .animation(.default, value: isBarExpanded)
                            .foregroundColor(.white)
                    )
            }
            .frame(width: isBarExpanded ? 90 : 18, height: 400)
            .animation(.default, value: isBarExpanded)
        }
    }
}

#Preview {
    SlideBar()
}
