//
//  ExpandableBlockView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct ExpandableBlockView<Content: View>: View {
    let title: String
    let content: () -> Content
    @Binding var isExpanded: Bool

    var body: some View {
        blockView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(title)
                    Spacer()
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    }
                }
                if isExpanded {
                    content()
                }
            }
        }
    }
}

@ViewBuilder
func blockView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        content()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
    .background(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.blue, lineWidth: 2))
}

#Preview {
    @State var isExpanded: Bool = false
    return ExpandableBlockView(title: "Заголовок", content: {
        EmptyView()
    }, isExpanded: $isExpanded)
}
