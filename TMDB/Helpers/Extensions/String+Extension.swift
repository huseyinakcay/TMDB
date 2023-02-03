//
//  String+Extension.swift
//  TMDB
//
//  Created by Huseyin Akcay on 3.02.2023.
//

import Foundation

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ) as? [String: Any]
        }
        return nil
    }
}
