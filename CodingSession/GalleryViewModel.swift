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
    
    let cellWidth: CGFloat
    
    init(videoProvider: VideoProviderProtocol, cellWidth: CGFloat) {
        self.videoProvider = videoProvider
        self.cellWidth = cellWidth
    }
    
    func fetchPhotos() {
        let videos = videoProvider.getVideos()
        
        var controllers: [CellController] = []
        
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = .positional
        
        let targetSize = CGSize(width: 130, height: 130)
        
        videos.forEach { asset in
            let title = formatter.string(from: asset.duration) ?? ""
            
            let controller = CellController(title: title) {
                let resultImageData = await withCheckedContinuation { continuation in
                    manager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                        continuation.resume(returning: image?.pngData())
                    }
                }
                
                return resultImageData ?? Data()
            }
            
            controllers.append(controller)
        }
        
        self.cellControllers.accept(controllers)
    }
}
