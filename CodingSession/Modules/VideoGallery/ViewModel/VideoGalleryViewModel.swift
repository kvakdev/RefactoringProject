//
//  GalleryViewModel.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import RxRelay

class VideoGalleryViewModel {
    private let videoProvider: VideoProviderProtocol
    private let accessProvider: PhotosAccessProviderProtocol
    
    private(set) var cellControllers: PublishRelay<[CellController]> = .init()
    private(set) var settingsButtonHidden: BehaviorRelay<Bool> = .init(value: true)
    
    init(videoProvider: VideoProviderProtocol, accessProvider: PhotosAccessProviderProtocol) {
        self.videoProvider = videoProvider
        self.accessProvider = accessProvider
    }
    
    private func fetchPhotos() {
        self.cellControllers.accept(videoProvider.getVideos())
    }
    
    func start() async {
        let isAllowed = await accessProvider.isAllowed()
        
        if isAllowed {
            fetchPhotos()
        } else {
            settingsButtonHidden.accept(false)
        }
    }
}

