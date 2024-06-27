//
//  ConfigData.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 12.06.2024.
//

import Foundation

struct ConfigData{
    let BASE_URL = "https://app.nasotku.ru"
    let APP_USER_AGENT = "nasotku-free-ios-app"
    let razrabUrl = "https://app.nasotku.ru"

    let VK_ID = "51873425"
    let VK_SECRET_KEY = "U66dtZfGWyvWknZqcX1Y"
    //Токен при первичной авторизации на сервере
    let FIRST_TOKEN = ""

    //Переменные для формирования подписи запроса
    let APP_SECRET_KEY_INT = 0
    let APP_SECRET_KEY_STRING = ""

    // Адрес апи
    let apiAddr = "/app/api"
}
