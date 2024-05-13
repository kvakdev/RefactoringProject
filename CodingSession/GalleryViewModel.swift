//
//  GalleryViewModel.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import RxSwift
import Photos

class GalleryViewModel {
    private let videoProvider: VideoProviderProtocol
    
    init(videoProvider: VideoProviderProtocol) {
        self.videoProvider = videoProvider
    }
    
    func fetchPhotos() -> [PHAsset] {
        return videoProvider.getVideos()
    }
}
