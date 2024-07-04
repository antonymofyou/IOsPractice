//
//  CandidateAnswersView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct CandidateAnswersView: View {
    @EnvironmentObject var viewModel: OtklikDetailViewModel
    @State var isExpanded: Bool = false

    var body: some View {
        ExpandableBlockView(
            title: "Ответы кандидата",
            content: {
                ForEach(viewModel.answers, id: \.self) { answer in
                    VStack(alignment: .leading) {
                        Text(answer["question"] ?? "Нет вопроса")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        Text(answer["answer"] ?? "Нет ответа")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            },
            isExpanded: $isExpanded
        )
    }
}

#Preview {
    var viewModel: OtklikDetailViewModel = OtklikDetailViewModel(id: "64", otklikId: "34", candidateId: "5")
    return CandidateAnswersView().environmentObject(viewModel)
}
