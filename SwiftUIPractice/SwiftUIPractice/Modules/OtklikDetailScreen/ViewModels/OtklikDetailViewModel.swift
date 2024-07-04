//
//  OtklikDetailViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 04.07.2024.
//

import Foundation

class OtklikDetailViewModel: ObservableObject {
    @Published var commentsforCandidate: [[String: String]] = []
    @Published var commentsforOtklik: [[String: String]] = []
    @Published var answers: [[String: String]] = []
    @Published var otklikInfo: [String: String] = [:]
    @Published var statusTransfers: [String] = []
    @Published var candidatesStatus: CandidatesDownloadingState = .loading
    @Published var isCommentOnOtklikCreated: Bool = false
    @Published var isCommentOnCandidateCreated: Bool = false
    var id: String
    var candidateId: String
    var otklikId: String
    let vacancyResponseModel = OtklikDetailModel()

    init(id: String, otklikId: String, candidateId: String) {
        self.id = id
        self.candidateId = candidateId
        self.otklikId = otklikId
        obtainData(otklikId: otklikId, candidateId: candidateId)
    }

    func createCommentOnOtklik(comment: String) {
        vacancyResponseModel.CreateCandidateComment(
            candidateId: candidateId,
            commentText: comment,
            commentFor: "for_otklik:\(otklikId)")
        { response in
            self.vacancyResponseModel.GetCandidateComments(
                candidateId: self.candidateId,
                commentFor: "for_otklik:\(self.otklikId)")
            { result in
                switch result {
                case .success(let answer):
                    self.commentsforOtklik = answer.comments
                    self.isCommentOnOtklikCreated.toggle()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }

    func createCommentOnCandidate(comment: String) {
        vacancyResponseModel.CreateCandidateComment(
            candidateId: candidateId,
            commentText: comment,
            commentFor: "for_candidate")
        { response in
            switch response {
            case .success(let answer):
                self.vacancyResponseModel.GetCandidateComments(
                    candidateId: self.candidateId,
                    commentFor: "for_candidate:")
                { result in
                    switch result {
                    case .success(let answer):
                        self.commentsforCandidate = answer.comments
                        self.isCommentOnCandidateCreated.toggle()
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    func obtainData(otklikId: String, candidateId: String) {

        vacancyResponseModel.GetCandidateComments(candidateId: candidateId, commentFor: "for_candidate") { result in
            switch result {
            case .success(let answer):
                self.commentsforCandidate = answer.comments
            case .failure(let error):
                print("error: \(error)")
            }
        }

        vacancyResponseModel.GetCandidateComments(candidateId: candidateId, commentFor: "for_otklik:\(otklikId)") { result in
            switch result {
            case .success(let answer):
                self.commentsforOtklik = answer.comments
            case .failure(let error):
                print("error: \(error)")

            }
        }

        vacancyResponseModel.GetOtklikInfo(otklikId: otklikId) { result in
            switch result {
            case .success(let answer):
                self.answers = answer.answers
                self.otklikInfo = answer.info
                self.statusTransfers = answer.statusTransfers
                self.candidatesStatus = .success
            case .failure(let error):
                print("error: \(error)")

            }
        }
    }

    func setStatus(toStatusName: String) {
        vacancyResponseModel.SetOtklikStatus(otklikId: otklikId, toStatusName: toStatusName) { result in
            switch result {
            case .success(let answer):
                print("статус успешно изменен")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

enum CandidatesDownloadingState {
    case loading, success
}

