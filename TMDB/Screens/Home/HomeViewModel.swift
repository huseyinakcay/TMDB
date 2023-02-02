//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import Foundation
import Alamofire

class HomeViewModel {
    //MARK: - Properties
    var results: [Results] = []
    private var page = 1
    private var pageCount = 0
    var isFetchingData = false
    var isLastPage: Bool {
        page > pageCount
    }

    //MARK: - Methods
    func fetchMovies(
        onSuccess: @escaping (Int, Int) -> Void,
        onFailure: @escaping (String?, APIError) -> Void
    ) {
        if !isFetchingData {
            isFetchingData.toggle()
            APIService.request(
                router: TvShowsEndpoint.popularShows(page: self.page)
            ) { (response: PopularShowsResponseModel?, error: String?) in
                guard let response = response,
                      let results = response.results else {
                    onFailure(commonError, .unknownError)
                    return
                }
                let count = self.results.count
                let newCount = count + results.count - 1
                self.results += results
                self.page += 1
                self.pageCount = response.totalPages ?? 1
                self.isFetchingData.toggle()
                onSuccess(count, newCount)
            } onFailure: { (errorDescription, networkErrorType) in
                self.isFetchingData.toggle()
                onFailure(errorDescription, networkErrorType)
            }
        }

    }
}
