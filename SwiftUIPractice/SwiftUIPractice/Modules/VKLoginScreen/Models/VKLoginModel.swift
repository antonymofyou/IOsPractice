//
//  VKLoginModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 27.06.2024.
//

import Foundation
import Alamofire

class VKLoginModel {

    func GetNasotkuToken(vkToken: String, vkUserId: Int, completion: @escaping(Result<VKLoginResponse, Error>) -> Void) {
        let req = VkLoginRequest()
        req.vkToken = vkToken
        req.vkUserId = String(vkUserId)
        req.make_signature(nasotku_token: ConfigData().FIRST_TOKEN)

        let url = ConfigData().BASE_URL + ConfigData().apiAddr + "/auth/get_nasotku_token.php"

        AF.request(url, method: .post, parameters: req, encoder: .json)
            .responseDecodable(of: VKLoginResponse.self) { response in

                if(response.error != nil){
                    completion(.failure("Ошибка 1: \(response.error!.errorDescription!)" )
                    )}
                else if(response.value == nil){
                    completion(.failure("Нулевой ответ от сервера"))
                }
                else if(response.value!.success=="0"){

                    completion(.failure("Запрос неуспешен " + response.value!.message))
                }
                else if(response.value!.success=="-1"){
                    completion(.failure("-1"))
                }
                else if(response.value!.nasotkuToken.isEmpty && response.value!.device.isEmpty){
                    completion(.failure("Нет подходящих данных"))
                }
                else{
                    completion(.success(response.value!))
                }
            }
    }
}

extension String: Error {}
