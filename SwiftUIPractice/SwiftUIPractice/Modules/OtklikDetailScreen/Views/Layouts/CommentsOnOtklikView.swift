//
//  CommentsOnOtklikView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct CommentsOnOtklikView: View {
    @EnvironmentObject var viewModel: OtklikDetailViewModel
    @State var newComment: String = ""

    var body: some View {
        blockView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Комментарии на отклик кандидата")
                if viewModel.commentsforCandidate.isEmpty {
                    Text("Нет комментариев")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                } else {
                    ForEach(viewModel.commentsforOtklik, id: \.self) { option in
                        CommentView(name: option["managerName"] ?? "", text: option["comment"] ?? "", date: option["createdAt"] ?? "")
                    }
                }

                Text("Создать комментарий")
                TextEditor(text: $newComment)
                    .frame(minHeight: 38, maxHeight: .infinity)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                    .onReceive(viewModel.$isCommentOnOtklikCreated) { isCreated in
                        if isCreated {
                            newComment = ""
                        }
                    }
                HStack {
                    Spacer()
                    BlueButton(title: "Добавить комментарий") {
                        viewModel.createCommentOnOtklik(comment: newComment)
                    }
                }
            }
        }
    }
}


#Preview {
    var viewModel: OtklikDetailViewModel = OtklikDetailViewModel(id: "64", otklikId: "34", candidateId: "5")
    return CommentsOnOtklikView().environmentObject(viewModel)
}
