//
//  CanvasViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

class CanvasViewModel {
    let jsonData = """
    [
        {
            "id": 1,
            "type": "rectangle",
            "x": 170,
            "y": 100,
            "width": 200,
            "height": 100,
            "color": "#FF5733",
            "borderColor": "#C70039",
            "zIndex": 0.5,
            "cornerRadius": 20,
            "borderWidth": 5,
            "rotation":90
        },
        {
            "id": 2,
            "type": "image",
            "x": 200,
            "y": 600,
            "width": 150,
            "height": 150,
            "image": "cat",
            "zIndex": 0.7,
        },
        {
            "id": 3,
            "type": "arrow",
            "x": 200,
            "y": 200,
            "width": 250,
            "height": 150,
            "borderColor": "#C70039",
            "zIndex": 0.2,
            "rotation":110
        },
        {
            "id": 4,
            "type": "rectangle",
            "x": 170,
            "y": 100,
            "width": 200,
            "height": 100,
            "color": "#FF5733",
            "borderColor": "#C70039",
            "zIndex": 0.5,
            "text": [
                {
                    "text": "Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!",
                    "type": "bold",
                    "fontSize": 24,
                    "fontColor": "#333333"
                },
                {
                    "text": " This is a test text.",
                    "fontSize": 18,
                    "fontColor": "#333333"
                }
            ],
            "borderWidth": 5
        },
    ]
    """.data(using: .utf8)!

    func getJSonData() -> [CanvasElementModel] {
        var shapesArray: [CanvasElementModel] = []

        do {
            let decodedData = try JSONDecoder().decode([CanvasElementModel].self, from: jsonData)
            shapesArray = decodedData
        } catch {
            print("Error decoding JSON: \(error)")
        }

        return shapesArray
    }
}
