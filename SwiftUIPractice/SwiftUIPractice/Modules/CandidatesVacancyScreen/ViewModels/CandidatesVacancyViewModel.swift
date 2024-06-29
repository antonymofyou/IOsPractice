//
//  VacancyResponseViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import Foundation
final class CandidatesVacancyViewModel: ObservableObject {
    @Published var candidates: [String: String] = [:]
    @Published var comments: [String: String] = [:]
    @Published var candidatesStatus: CandidatesDownloadingState = .loading

    init() {
        obtainData()
    }

    func obtainData() {
        let candidatesVacancyModel = CandidatesVacancyModel()
        candidatesVacancyModel.GetCandidatesById { result in
            switch result {
            case .success(let answer):
                self.candidates = answer.candidates.first ?? [:]
                print(self.candidates)
                self.candidatesStatus = .success
            case .failure(let error):
                print("error: \(error)")

            }
        }
        candidatesVacancyModel.GetCandidateComments { result in
            switch result {
            case .success(let answer):
                self.comments = answer.comments.first ?? [:]
                print(self.comments)
            case .failure(let error):
                print("error: \(error)")

            }
        }
    }
}

enum CandidatesDownloadingState {
    case loading, success
}
