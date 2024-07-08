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
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Color.white
                    .edgesIgnoringSafeArea(.all)

                HStack(spacing: 0) {
                    VStack {
                        Spacer()

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
                        .frame(width: isBarExpanded ? 90 : 0, height: geometry.size.height)
                        .clipped()
                        .background(Color.gray)
                        .animation(.default, value: isBarExpanded)

                        Spacer()
                    }

                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.gray)
                        .ignoresSafeArea(.all)
                        .frame(width: 22, height: isBarExpanded ?  geometry.size.height:  geometry.size.height * 0.15)
                        .offset(x: -6)
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
                .animation(.default, value: isBarExpanded)

                if isBarExpanded {
                    Color.clear
                        .contentShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isBarExpanded = false
                            }
                        }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SlideBar()
}
