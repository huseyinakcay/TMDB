//
//  PopularShowsResponseModel.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation

struct PopularShowsResponseModel: Codable {
    let results: [Results]?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

struct Results: Codable {
    let name: String?
    let posterPath: String?
    let voteAverage: Double?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case id
    }
}
