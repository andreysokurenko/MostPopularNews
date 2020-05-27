//
//  NetworkService.swift
//  MostPopularNews
//
//  Created by Andrey on 25.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import Alamofire

    
    struct NetworkService {
        func getJsonData(dataType: String, completion: @escaping URLComponent.Clouser) {
            let requestUrl = URLComponent.url + dataType + URLComponent.days + URLComponent.apiKey
            Alamofire.request(requestUrl).responseJSON { (response) in
                if let data = response.data {
                    switch response.result {
                    case .success(_):
                        completion(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        func getDataJsonShared(dataType: String, completion: @escaping URLComponent.Clouser) {
            let requestUrl = URLComponent.url + dataType + URLComponent.daysShared + URLComponent.apiKey
                   Alamofire.request(requestUrl).responseJSON { (response) in
                       if let data = response.data {
                           switch response.result {
                           case .success(_):
                               completion(data)
                           case .failure(let error):
                               print(error.localizedDescription)
                           }
                       }
                   }
               }
        
    }
    
   
    
    

    
    
    
    
    
    
    
    
    
    
    
//    let keyId = "sYXMp2w0aA4vlMToyplLNmKpKZQ5kBq0"
//
//
//
//    func fetchTracks(competion: @escaping (Empty?) -> Void)  {
//        let url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=sYXMp2w0aA4vlMToyplLNmKpKZQ5kBq0"
//
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
//             if let error = dataResponse.error {
//                 print("Error received requestiong data: \(error.localizedDescription)")
//                 competion(nil)
//                 return
//             }
//
//             guard let data = dataResponse.data else { return }
//
//             let decoder = JSONDecoder()
//             do {
//                 let objects = try decoder.decode(Empty.self, from: data)
//                 competion(objects)
//
//             } catch let jsonError {
//                 print("Failed to decode JSON", jsonError)
//                 competion(nil)
//             }
//         }
//     }
//
//
////        static func sendRequest(url: String) {
////
////        guard let url = URL(string: url) else { return }
////
////        request(url, method: .get).validate().responseJSON { (response) in
////
////            switch response.result {
////
////            case .success(let value):
////                print(value)
////            case .failure(let error):
////                print(error)
////            }
////        }
////    }

    
    
    
    

