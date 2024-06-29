//
//  VacancyResponseModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 29.06.2024.
//

import Foundation
import Alamofire
final class CandidatesVacancyModel {

    // Получение откликов кандидатов по вакансии
    func GetCandidatesById(completion: @escaping(Result<CandidateByVacancyResponse, Error>) -> Void) {

        let req = CandidateByVacancyRequest()
        req.device = ConfigData().device
        req.vacancyId = "178"
        req.status = ""
        req.make_signature(nasotku_token: ConfigData().token)

        let url = ConfigData().BASE_URL + ConfigData().apiAddr + "/candidates/get_candidates_by_vacancy_id.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: CandidateByVacancyResponse.self) { response in

            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.candidates.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих вакансий"])))
                } else {
                    print(vacancyResponse.candidates)
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func GetCandidateComments(completion: @escaping(Result<CandidateCommentResponse, Error>) -> Void) {
        let req = CandidateCommentsRequest()
        req.device = ConfigData().device
        req.candidateId = "5"
        req.commentFor = ""
        req.make_signature(nasotku_token: ConfigData().token)

        let url = ConfigData().BASE_URL + ConfigData().apiAddr + "/candidates/get_candidate_comments.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: CandidateCommentResponse.self) { response in

            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.comments.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих вакансий"])))
                } else {
                    print(vacancyResponse.comments)
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
