//
//  ModelMostEmailed.swift
//  MostPopularNews
//
//  Created by Andrey on 25.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct Empty: Decodable {
    
    let results: [Result]
    
}

struct Result: Decodable {
    let url: String?
    let title: String?
}
