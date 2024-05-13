//
//  GalleryViewModel.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import RxSwift
import Photos
import RxRelay

class CellController {
    let title: String
    let getImagePNGData: () async -> Data
    
    internal init(title: String, getImagePNGData: @escaping () async -> Data) {
        self.getImagePNGData = getImagePNGData
        self.title = title
    }
}

class GalleryViewModel {
    private let videoProvider: VideoProviderProtocol
    
    var cellControllers: PublishRelay<[CellController]> = .init()
    
    private let cellWidth: CGFloat
    private let mapper: (PHAsset, Double) -> CellController
    
    init(videoProvider: VideoProviderProtocol, cellWidth: CGFloat, mapper: @escaping (PHAsset, Double) -> CellController) {
        self.videoProvider = videoProvider
        self.cellWidth = cellWidth
        self.mapper = mapper
    }
    
    func fetchPhotos() {
        let videos = videoProvider.getVideos()
        let cellControllers = videos.map { self.mapper($0, cellWidth) }
        
        self.cellControllers.accept(cellControllers)
    }
}
