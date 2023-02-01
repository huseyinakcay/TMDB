//
//  APIError.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation

enum APIError {
    case noConnection

    var errorDescription: String {
        switch self {
        case .noConnection:
            return "Check your connection"
        }
    }
}
