//
//  GalleryViewModel.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import Photos
import RxRelay

class VideoGalleryViewModel {
    private let videoProvider: VideoProviderProtocol
    
    private(set) var cellControllers: PublishRelay<[CellController]> = .init()
    private(set) var settingsButtonHidden: BehaviorRelay<Bool> = .init(value: true)
    
    init(videoProvider: VideoProviderProtocol) {
        self.videoProvider = videoProvider
    }
    
    private func fetchPhotos() {
        self.cellControllers.accept(videoProvider.getVideos())
    }
    
    func start() {
        checkAuthorizationStatus()
    }
    
    private func checkAuthorizationStatus() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            switch status {
            case .restricted, .denied:
                self?.settingsButtonHidden.accept(false)
            case .authorized, .limited, .notDetermined:
                self?.fetchPhotos()
            @unknown default:
                self?.fetchPhotos()
            }
        }
    }
}
