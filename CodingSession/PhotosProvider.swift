//
//  PhotosProvider.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import Photos

protocol VideoProviderProtocol {
    func getVideos() -> [PHAsset]
}
//TODO: - Make static func
class VideoProvider: VideoProviderProtocol {
    func getVideos() -> [PHAsset] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        var videoAssets: [PHAsset] = []
           
        fetchResult.enumerateObjects { (asset, _, _) in
            videoAssets.append(asset)
        }
        
        return videoAssets
    }
}
