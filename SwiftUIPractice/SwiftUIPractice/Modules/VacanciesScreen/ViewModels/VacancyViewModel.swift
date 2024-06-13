//
//  VacancyViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.06.2024.
//

import SwiftUI
import Combine

class VacanciesViewModel: ObservableObject {

    @Published var vacancies: [[String: String]] = [] //Массив словарей вакансий
    @Published var vacancyStatus: VacancyDownloadingState = .loading //Статус View

    init() {
        obtainData()
    }

    func obtainData() {
        let vacancyModel = VacancyModel()
        vacancyModel.GetAllVacancies { result in
            switch result {
            case .success(let answer):
                self.vacancies = answer.vacancies
                self.vacancyStatus = .success
            case .failure(let error):
                print("error: \(error)")

            }
        }
    }
}

enum VacancyDownloadingState {
    case loading, success
}

