//
//  CellController.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation

class CellController {
    let title: String
    let getImagePNGData: () async -> Data
    
    internal init(title: String, getImagePNGData: @escaping () async -> Data) {
        self.getImagePNGData = getImagePNGData
        self.title = title
    }
}
