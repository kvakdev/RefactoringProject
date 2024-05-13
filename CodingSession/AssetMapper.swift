//
//  AssetMapper.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import Photos

struct AssetMapper {
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        formatter.unitsStyle = .positional
        
        return formatter
    }()
    
    private let requestOptions: PHImageRequestOptions = {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        
        return requestOptions
    }()
    
    private let manager: PHImageManager
    
    init(manager: PHImageManager) {
        self.manager = manager
    }
    
    func map(asset: PHAsset, imageSize: Double) -> CellController {
        let title = formatter.string(from: asset.duration) ?? ""
        
        let controller = CellController(title: title) {
            let resultImageData = await withCheckedContinuation { continuation in
                manager.requestImage(for: asset, targetSize: CGSize(width: imageSize, height: imageSize), contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    continuation.resume(returning: image?.pngData())
                }
            }
            
            return resultImageData ?? Data()
        }
        
        return controller
    }
}
