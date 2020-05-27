//
//  URLComponent.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct URLComponent {
    
    enum keyPartUrl: String {
        case emailed = "/emailed"
        case shared = "/shared"
        case viewed = "/viewed"
    }
    
    typealias Clouser = (Data) -> ()
    
    static let url = "https://api.nytimes.com/svc/mostpopular/v2"
    static let days = "/30.json?"
    static let daysShared = "/30/facebook.json?"
    static let apiKey = "api-key=sYXMp2w0aA4vlMToyplLNmKpKZQ5kBq0"
}
