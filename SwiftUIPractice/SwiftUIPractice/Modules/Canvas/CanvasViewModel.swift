//
//  CanvasViewModel.swift
//  SwiftUIPractice
//
//  Created by Давид Васильев on 13.07.2024.
//

import SwiftUI

class CanvasViewModel: ObservableObject {
    var imagesDict: [String: UIImage] = [:]
    var elementsArray: [CanvasElementModel] = []
    func convertJsonToCanvasData(jsonData: Data) {
        var shapesArray: [CanvasElementModel] = []
        var uiImageDictionary: [String: UIImage] = [:]

        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                if let imageDict = json["imageDictionary"] as? [String: String] {
                    for (key, base64String) in imageDict {
                        if let uiImage = convertBase64ToUIImage(base64String: base64String) {
                            uiImageDictionary[key] = uiImage
                        }
                    }
                }
                if let shapesData = json["shapes"] {
                    let shapesJsonData = try JSONSerialization.data(withJSONObject: shapesData)
                    shapesArray = try JSONDecoder().decode([CanvasElementModel].self, from: shapesJsonData)
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
        imagesDict = uiImageDictionary
        elementsArray = shapesArray
    }

    private func convertBase64ToUIImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
}

/// Пример json
/*
 {
     "imageDictionary": {},
     "shapes": [
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
             "imageId": "1",
             "zIndex": 0.7,
             "cornerRadius": 40
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
             "textVerticalAlignment": "top",
             "text": [
                 {
                     "alignment": "left",
                     "text": [
                         {
                             "text": "Hello",
                             "type": "bold",
                             "fontSize": 24,
                             "fontColor": "#333333"
                         },
                         {
                             "text": " This is a test text.",
                             "fontSize": 18,
                             "fontColor": "#333333"
                         }
                     ]
                 },
                 {
                     "alignment": "right",
                     "text": [
                         {
                             "text": "Hello",
                             "type": "bold",
                             "fontSize": 24,
                             "fontColor": "#333333"
                         },
                         {
                             "text": " This is a test text.",
                             "fontSize": 18,
                             "fontColor": "#333333"
                         }
                     ]
                 }

             ],
             "borderWidth": 5
         }
     ]
 }
 */
