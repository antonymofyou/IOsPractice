//
//  VacancyModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.06.2024.
//

import Foundation
import Alamofire

class VacancyModel {

    // Получение всех вакансий с API
    func GetAllVacancies(completion: @escaping(Result<VacancyResponse, Error>) -> Void) {
        let req = VacancyRequest()
        req.device = ConfigData.device
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/vacancies/get_all_vacancies.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: VacancyResponse.self) { response in

            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.vacancies.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих вакансий"])))
                } else {
                    print(vacancyResponse.vacancies)
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
