//
//  UILabel+Extension.swift
//  TMDB
//
//  Created by Huseyin Akcay on 3.02.2023.
//

import UIKit

extension UILabel {
    public func addAttribute(text: String = "", attText: String, color: UIColor, highletedFont: UIFont) {
        var currentText = text
        if currentText == "" {
            currentText = self.text ?? ""
        }
        let attrStri = NSMutableAttributedString.init(string:currentText)
        let nsRange = NSString(string: currentText).range(of: attText, options: String.CompareOptions.caseInsensitive)


        attrStri.addAttributes([NSAttributedString.Key.foregroundColor: color,
                                NSAttributedString.Key.font: highletedFont], range: nsRange)

        self.attributedText = attrStri

    }
}
