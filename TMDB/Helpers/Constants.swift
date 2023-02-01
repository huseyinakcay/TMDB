//
//  Constants.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

public let customFont = "Baskerville"
public let commonError = "Error"
public let commonOk = "OK"

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

    }

    enum Detail {

    }
}
