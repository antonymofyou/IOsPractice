//
//  API_root_class.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 12.06.2024.
//

import Foundation
import CryptoKit
import SerializedSwift

class API_root_class:Serializable{

    @Serialized(default:"")
    var signature:String//подпись, которая формируется с помощью метода make_signature() из этого класса

    required init() {}

    func calc_signature(nasotku_token:String) -> String{

        //добавляем(конкатенируем) два ключа(int+string) и добавляем токен
        let app_secret_key_int = ConfigData().APP_SECRET_KEY_INT
        let app_secret_key_str = ConfigData().APP_SECRET_KEY_STRING
        var signature_text = ""

        var mir:Mirror? = Mirror(reflecting: self)

        var name:String = ""
        //var value:String=""
        //var valType:String=""

        var keys:[String] = []
        var mydict:Dictionary<String,String> = [:]

        //формируем словарь и массив ключ-значение в классе. Массив - для сортировки
        while((mir) != nil){
            for child in mir!.children {
                name = String(describing: child.label.unsafelyUnwrapped)
                //value = String(describing: child.value)
                //valType = String(describing: type(of: child.value))
                //print(name+" '"+value+"' "+valType)
                if (child.value is Serialized<String> && name != "_signature"){
                    let k:Serialized<String> = child.value as! Serialized<String>
                    //print("!!!",k.wrappedValue)

                    keys.append(name)
                    mydict[name] = k.wrappedValue

                    /*if(child.value is String && name != "signature"){
                        keys.append(name)
                        mydict[name] = value
                    }*/
                }

            }
            mir=mir?.superclassMirror//получаем переменные суперкласса
        }

        keys=keys.sorted()

        //print("keys",keys)
        //print(mydict)

        for key in keys{
            signature_text+=mydict[key] ?? ""
        }
        signature_text+=(String(app_secret_key_int) + app_secret_key_str + nasotku_token)

        let data = signature_text.data(using: .utf8)

        return SHA256.hash(data: data!).compactMap{String(format: "%02x", $0)}.joined()
    }

    func make_signature(nasotku_token: String){//метод назначает подпись данному объекту
        signature = calc_signature(nasotku_token: nasotku_token)
    }

    func check_signature(nasotku_token: String) -> Bool{//проверка подписи для входящих запросов(полученных ответов)
        return signature == calc_signature(nasotku_token: nasotku_token) //возвращает единицу, если подпись, которая пришла совпадает с вычисленной
    }


}
