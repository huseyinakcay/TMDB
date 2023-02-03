//
//  ShowDetailResponseModel.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation

struct ShowDetailResponseModel: Codable {
    let createdBy: [CreatedBy]?
    let overview: String?
    let type: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let inProduction: Bool?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case overview
        case type
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case inProduction = "in_production"
        case name
    }
}

struct CreatedBy: Codable {
    let name: String?
}
