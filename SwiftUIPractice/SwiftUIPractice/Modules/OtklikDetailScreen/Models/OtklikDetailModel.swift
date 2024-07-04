//
//  OtklikDetailModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Alamofire
import Foundation
class OtklikDetailModel {

    func GetCandidatessByID(vacancyId: String, completion: @escaping(Result<VacancyByIdResponse, Error>) -> Void) {
        let req = VacancyByIdRequest()
        req.device = ConfigData.device
        req.vacancyId = vacancyId
        req.status = ""
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/get_candidates_by_vacancy_id.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: VacancyByIdResponse.self) { response in

            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.candidates.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих вакансий"])))
                } else {
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func GetCandidateComments(candidateId: String, commentFor: String, completion: @escaping(Result<CandidateCommentResponse, Error>) -> Void) {
        let req = CandidateCommentsRequest()
        req.device = ConfigData.device
        req.candidateId = candidateId
        req.commentFor = commentFor
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/get_candidate_comments.php"

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
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func GetOtklikInfo(otklikId: String, completion: @escaping(Result<OtklikInfoResponse, Error>) -> Void) {
        let req = OtklikInfoRequest()
        req.device = ConfigData.device
        req.otklikId = otklikId
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/get_otklik_info.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseDecodable(of: OtklikInfoResponse.self) { response in
            print(response)
            switch response.result {
            case .success(let vacancyResponse):
                if vacancyResponse.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(vacancyResponse.message)"])))
                } else if vacancyResponse.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else if vacancyResponse.info.isEmpty {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет подходящих вакансий"])))
                } else {
                    completion(.success(vacancyResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func CreateCandidateComment(candidateId: String, commentText: String, commentFor: String, completion: @escaping(Result<SetCandidateCommentResponse, Error>) -> Void) {
        let req = SetCandidateCommentRequest()
        req.device = ConfigData.device
        req.candidateId = candidateId
        req.action = "create"
        req.commentFor = commentFor
        req.commentText = commentText
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/set_candidate_comment.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseString(completionHandler: { result in
        }).responseDecodable(of: SetCandidateCommentResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(response.message)"])))
                } else if response.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else {
                    completion(.success(response))
                }
            case .failure(let error):
                print(response.value ?? "нет значения")
                completion(.failure(error))
            }
        }
    }

    func SetOtklikStatus(otklikId: String, toStatusName: String, completion: @escaping(Result<MainResponseClass, Error>) -> Void) {
        let req = CandidatesSetOtklikStatusRequest()
        req.device = ConfigData.device
        req.otklikId = otklikId
        req.toStatusName = toStatusName
        req.make_signature(nasotku_token: ConfigData.token)

        let url = ConfigData.BASE_URL + ConfigData.apiAddr + "/candidates/set_otklik_status.php"

        AF.request(url, method: .post, parameters: req, encoder: .json).responseString(completionHandler: { result in
        }).responseDecodable(of: MainResponseClass.self) { response in
            switch response.result {
            case .success(let response):
                if response.success == "0" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Запрос неуспешен: \(response.message)"])))
                } else if response.success == "-1" {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "-1"])))
                } else {
                    completion(.success(response))
                }
            case .failure(let error):
                print(response.value ?? "нет значения")
                completion(.failure(error))
            }
        }
    }
}

