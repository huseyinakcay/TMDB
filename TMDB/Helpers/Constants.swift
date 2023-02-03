//
//  Constants.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

public let commonFont = "Baskerville"
public let commonError = "Error"
public let commonOk = "OK"
public let popular = "popular"
public let language = "en-US"

enum Images: String {
    case splashLogo = "SplashLogo"

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

enum Constants {
    enum Splash {
        static let welcome = "WELCOME"
    }

    enum Home {
        static let home = "HOME"
        static let homeCvCell = "HomeVcCollectionViewCell"
    }

    enum Detail {
        static let detail = "ABOUT SHOW"
        static let detailTvCell = "DetailVcTableViewCell"
        static let yes = "Yes"
        static let no = "No"
        static let firstEpisode = "First Episode:"
        static let lastEpisode = "Last Episode:"
        static let didItEnd = "Did it end?:"
        static let genre = "Genre:"
        static let creator = "Creator:"
    }
}
