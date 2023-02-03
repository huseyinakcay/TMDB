//
//  DetailViewModel.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

final class DetailViewModel {
    //MARK: - Properties
    var mainModel: Results?
    var model: ShowDetailResponseModel?
    var posterImage: UIImage?
    var showId: String?

    init(mainModel: Results, posterImage: UIImage) {
        self.mainModel = mainModel
        self.posterImage = posterImage
        self.showId = "\(mainModel.id ?? 0)"
    }

    //MARK: - Methods
    func fetchShowDetail(
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String?, APIError) -> Void
    ) {
        APIService.request(
            router: TvShowsEndpoint.showDetail(id: showId ?? "")
        ) { (response: ShowDetailResponseModel?, error: String?) in
            guard let response = response else {
                onFailure(commonError, .unknownError)
                return
            }
            self.model = response
            onSuccess()
        } onFailure: { (errorDescription, networkErrorType) in
            onFailure(errorDescription, networkErrorType)
        }
    }
}
