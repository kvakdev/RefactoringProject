//
//  PhotosProvider.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Foundation
import Photos

class VideoProvider: VideoProviderProtocol {
    private let mapper: AssetMapper
    
    init(mapper: AssetMapper) {
        self.mapper = mapper
    }
    
    func getVideos() -> [CellController] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        var videoAssets: [PHAsset] = []
           
        fetchResult.enumerateObjects { (asset, _, _) in
            videoAssets.append(asset)
        }
        
        return videoAssets.map(mapper.map(asset:))
    }
}
