//
//  CommentsOnCandidateView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct CommentsOnCandidateView: View {
    @EnvironmentObject var viewModel: OtklikDetailViewModel
    @State var newComment: String = ""
    @State var isExpanded: Bool = false

    var body: some View {
        ExpandableBlockView(
            title: "Комментарии на кандидата",
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    if viewModel.commentsforCandidate.isEmpty {
                        Text("Нет комментариев")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    } else {
                        ForEach(viewModel.commentsforCandidate, id: \.self) { option in
                            CommentView(name: option["managerName"] ?? "", text: option["comment"] ?? "", date: option["createdAt"] ?? "")
                        }
                    }

                    Text("Создать комментарий")
                    TextEditor(text: $newComment)
                        .frame(minHeight: 38, maxHeight: .infinity)
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                        .onReceive(viewModel.$isCommentOnCandidateCreated) { isCreated in
                            if isCreated {
                                newComment = ""
                            }
                        }
                    HStack {
                        Spacer()
                        BlueButton(title: "Добавить комментарий") {
                            viewModel.createCommentOnCandidate(comment: newComment)
                        }
                    }
                }
            },
            isExpanded: $isExpanded
        )
    }
}

#Preview {
    var viewModel: OtklikDetailViewModel = OtklikDetailViewModel(id: "64", otklikId: "34", candidateId: "5")
    return CommentsOnCandidateView().environmentObject(viewModel)
}
