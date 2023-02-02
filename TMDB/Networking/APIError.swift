//
//  APIError.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation

enum APIError {
    case noConnection
    case unknownError

    var errorDescription: String {
        switch self {
        case .noConnection:
            return "Check your connection"
        case .unknownError:
            return "Something went wrong"
        }
    }
}
