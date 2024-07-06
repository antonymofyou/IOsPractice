//
//  VKIDAuthButton.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 27.06.2024.
//

import SwiftUI
import VKID

struct VKIDAuthButton: UIViewRepresentable {
    var oneTap: OneTapButton
    var vkid: VKID

    func makeUIView(context: Context) -> some UIView {
        vkid.ui(for: oneTap).uiView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
