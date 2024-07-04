//
//  CandidatesByVacancyModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 02.07.2024.
//

import Alamofire
import Foundation
class CandidatesByVacancyModel {

    // Получение откликов кандидатов по вакансии
    func GetCandidatessByID(vacancyId: String, completion: @escaping(Result<CandidatesByVacancyResponse, Error>) -> Void) {

        let req = CandidatesByVacancyRequest()
        req.device = ConfigData.device
        req.vacancyId = vacancyId
        req.status = ""
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/get_candidates_by_vacancy_id.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: CandidatesByVacancyResponse.self) { response in

            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.candidates.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих откликов"])))
                } else {
                    print(vacancyResponse.candidates)
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
