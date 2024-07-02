//
//  CandidatesByVacancyView.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import SwiftUI

struct CandidatesByVacancyView: View {
    @StateObject var viewModel: CandidatesByVacancyViewModel
    var vacancies: [[String: String]]
    var currentVacancy: [String: String]
    init(vacancy: [String: String], vacancies: [[String: String]]) {
        self.vacancies = vacancies
        self.currentVacancy = vacancy
        self._viewModel = StateObject(wrappedValue: CandidatesByVacancyViewModel(id: vacancy["id"] ?? "-1"))
    }

    var body: some View {
        switch viewModel.candidatesVacancyState {
        case .loading:
            ProgressView()
                .scaleEffect(1.5)
                .padding()

        case .success:
            CandidatesByVacancyContentView(selectedVacancyName: "\(currentVacancy["name"] ?? "")(id: \(currentVacancy["id"] ?? ""))", currentVacancy: currentVacancy, vacancies: vacancies).environmentObject(viewModel)
        }
    }
}
