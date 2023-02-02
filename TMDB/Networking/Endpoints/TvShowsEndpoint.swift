//
//  TvShowsEndpoint.swift
//  TMDB
//
//  Created by Huseyin Akcay on 2.02.2023.
//

import Foundation
import Alamofire

// popular -> /3/tv/popular?api_key=d8020e5e717dd4e28a9e77a73ebbd9da&language=en-US&page=1
// detail -> /3/tv/100088?api_key=d8020e5e717dd4e28a9e77a73ebbd9da&language=en-US
enum TvShowsEndpoint: APIEndpoint {
    case popularShows(page: Int)
    case showDetail(id: String)

    var method: Alamofire.HTTPMethod { return .get }

    var path: String {
        switch self {
        case .popularShows:
            return APIConstants.urlPath + popular
        case .showDetail(let id):
            return id
        }
    }

    var queryParameters: QueryStringParameters {
        var commonParameters = [
            APIConstants.ParameterKeys.apiKey.rawValue: APIConstants.apiKey,
            APIConstants.ParameterKeys.language.rawValue: language
        ]
        switch self {
        case .popularShows(let page):
            commonParameters[APIConstants.ParameterKeys.page.rawValue] = "\(page)"
            fallthrough
        case .showDetail:
            return commonParameters
        }
    }

    var httpBody: Data? { return nil }

    var headers: Alamofire.HTTPHeaders? { return nil }

}
