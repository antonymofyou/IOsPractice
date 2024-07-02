//
//  CandidatesByVacancyViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import Foundation

class CandidatesByVacancyViewModel: ObservableObject {
    @Published var candidates: [[String: String]] = []
    @Published var candidatesVacancyState: CandidatesVacancyDownloadingState = .loading

    init(id: String) {
        obtainData(id: id)
    }
    func obtainData(id: String) {
        let model = CandidatesByVacancyModel()
        model.GetCandidatessByID(vacancyId: id) { result in
            switch result {
            case .success(let answer):
                self.candidates = answer.candidates
                print(self.candidates)
                self.candidatesVacancyState = .success
            case .failure(let error):
                print("error: \(error)")

            }
        }
    }
}

enum CandidatesVacancyDownloadingState {
    case loading, success
}
