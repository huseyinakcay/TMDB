//
//  APIEndpoint.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation
import Alamofire

typealias QueryStringParameters = [String: String]?

protocol APIEndpoint: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryStringParameters { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders? { get }
}

extension APIEndpoint {
    func asURLRequest() throws -> URLRequest {
        let url = try (APIConstants.baseURL + path).asURL()

        var urlComponents = URLComponents(string: url.absoluteString)

        //Query Parameters
        urlComponents?.queryItems = queryParameters?.map { key, value in
            return URLQueryItem(name: key, value: value)
        }

        var urlRequest = URLRequest(url: (urlComponents?.url!)!)

        //HTTP Method
        urlRequest.httpMethod = method.rawValue

        //Headers
        urlRequest.headers = headers ?? ["Content-Type":"application/x-www-form-urlencoded; charset=utf-8"]

        //Parameters
        urlRequest.httpBody = httpBody

        return urlRequest
    }
}
