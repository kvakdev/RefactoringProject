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
    
    var cellControllers: PublishRelay<[CellController]> = .init()
    
    private let mapper: (PHAsset) -> CellController
    
    var requestSettings: (() -> Void)?
    
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
    
    func checkAuthorizationStatus() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
            switch status {
            case .notDetermined:
                self?.fetchPhotos()
            case .restricted:
                self?.requestSettings?()
            case .denied:
                self?.requestSettings?()
            case .authorized:
                self?.fetchPhotos()
            case .limited:
                self?.fetchPhotos()
            }
        }
    }
}
