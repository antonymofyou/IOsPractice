//
//  VacanciesViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 10.06.2024.
//

import Foundation
import Combine

class VacanciesViewModel: ObservableObject {

    @Published var vacancies: [VacancyModel] = [] //Массив словарей вакансий
    var vacancyStatus: VacancyDownloadingState = .SUCCESS //Статус получения данных

    init() {
        //Mock данных
        self.vacancies = [
            VacancyModel(info: ["id": 1, "name": "Front", "description": "Описание вакансии", "published": 1, "createdAt": "2023-06-01"]),
            VacancyModel(info: ["id": 2, "name": "Data Scientist", "description": "Описание вакансии", "published": 1, "createdAt": "2023-06-02"]),
            VacancyModel(info: ["id": 3, "name": "Project Manager", "description": "Описание вакансии", "published": 0, "createdAt": "2023-06-03"]),
            VacancyModel(info: ["id": 4, "name": "Project Manager", "description": "Описание вакансии", "published": 0, "createdAt": "2023-06-03"])
        ]
    }
}

enum VacancyDownloadingState {
    case LOADING, LOADED, SUCCESS
}
