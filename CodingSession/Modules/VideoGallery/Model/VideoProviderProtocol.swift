//
//  VideoProviderProtocol.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation

protocol VideoProviderProtocol {
    func getVideos() -> [CellController]
}
