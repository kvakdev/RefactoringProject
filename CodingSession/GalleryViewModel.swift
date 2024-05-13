//
//  GalleryViewModel.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import Photos
import RxRelay

class GalleryViewModel {
    private let videoProvider: VideoProviderProtocol
    
    private(set) var cellControllers: PublishRelay<[CellController]> = .init()
    private(set) var settingsButtonHidden: BehaviorRelay<Bool> = .init(value: true)
    
    private let mapper: (PHAsset) -> CellController
    
    init(videoProvider: VideoProviderProtocol, mapper: @escaping (PHAsset) -> CellController) {
        self.videoProvider = videoProvider
        self.mapper = mapper
    }
    
    private func fetchPhotos() {
        let videos = videoProvider.getVideos()
        let cellControllers = videos.map { self.mapper($0) }
        
        self.cellControllers.accept(cellControllers)
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
