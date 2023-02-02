//
//  APIConstants.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.themoviedb.org/"
    static let urlPath = "3/tv/"
    static var apiKey = "d8020e5e717dd4e28a9e77a73ebbd9da"

    enum ParameterKeys: String {
        case apiKey = "api_key"
        case language
        case page
    }
}

