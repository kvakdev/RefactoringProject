//
//  UIButton+Ext.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import UIKit

extension UIButton {
    static func makeSettingsButton() -> UIButton {
        var config = UIButton.Configuration.bordered()
        config.title = "Go to settings and allow access to videos"
        
        let button = UIButton(configuration: config, primaryAction: .init(handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        
        return button
    }
}
