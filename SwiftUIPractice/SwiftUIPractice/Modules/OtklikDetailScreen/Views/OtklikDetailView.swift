//
//  OtklikDetailView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import SwiftUI

struct OtklikDetailView: View {
    @StateObject var viewModel: OtklikDetailViewModel
    var vacancy: [String: String]

    init(vacancy: [String: String], otklikId: String, candidateId: String) {
        self.vacancy = vacancy
        self._viewModel = StateObject(wrappedValue: OtklikDetailViewModel(id: vacancy["id"] ?? "-1", otklikId: otklikId, candidateId: candidateId))
    }

    var body: some View {
        switch viewModel.candidatesStatus {
        case .loading:
            ProgressView()
                .scaleEffect(1.5)
                .padding()

        case .success:
            ScrollView {
                VStack(spacing: 20) {
                    Text("Отклик на вакансию")
                    OtklikStatusView().environmentObject(viewModel)
                    VacancyDescriptionView(vacancy: vacancy)
                    CandidateInfoView().environmentObject(viewModel)
                    CandidateAnswersView().environmentObject(viewModel)
                    CommentsOnOtklikView().environmentObject(viewModel)
                    CommentsOnCandidateView().environmentObject(viewModel)
                }
                .padding()
            }
        }
    }
}

#Preview {
    OtklikDetailView(vacancy: ["id":"64"], otklikId: "23", candidateId: "5")
}
