//
//  ActivityProgressView.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation
import UIKit

//MARK: Class for loader on screen
class ActivityProgressView: UIActivityIndicatorView {
    public static func indicator(at center: CGPoint, backgroundColor:UIColor = UIColor.gray) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        indicator.layer.cornerRadius = 10
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.backgroundColor = backgroundColor
        return indicator
    }
}
