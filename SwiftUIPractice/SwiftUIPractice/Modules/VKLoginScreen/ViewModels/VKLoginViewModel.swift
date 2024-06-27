//
//  VKLoginViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 27.06.2024.
//

import Foundation
import VKID

class VKLoginViewModel {

    var nasotkuToken: String = ""
    var device: String = ""
    var vkid: VKID
    var oneTap: OneTapButton {
        OneTapButton { [weak self] result in
            switch result {
            case .success(let session):
                self?.getNasotkuToken(vkToken: session.accessToken.value, vkUserId: session.userId.value)
                print("Auth succeeded with token: \(session.accessToken)")
            case .failure(let error):
                if error == AuthError.cancelled {
                    print("Authentication cancelled")
                } else {
                    print("Authentication failed with error: \(error)")
                }
            }
        }
    }

    init() {
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: ConfigData().VK_ID,
                        clientSecret: ConfigData().VK_SECRET_KEY
                    )
                )
            )
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
    }



    func getNasotkuToken(vkToken: String, vkUserId: Int) {
        let vkLoginModel = VKLoginModel()
        vkLoginModel.GetNasotkuToken(vkToken: vkToken, vkUserId: vkUserId) { result in
            switch result {
            case .success(let answer):
                self.nasotkuToken = answer.nasotkuToken
                self.device = answer.device
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

