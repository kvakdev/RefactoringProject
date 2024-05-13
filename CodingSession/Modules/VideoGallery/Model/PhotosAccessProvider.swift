//
//  PhotosAccessProvider.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import Photos

protocol PhotosAccessProviderProtocol {
    func isAllowed() async -> Bool
}

class PhotosAccessProvider: PhotosAccessProviderProtocol {
    func isAllowed() async -> Bool {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .restricted, .denied:
                    return continuation.resume(returning: false)
                case .authorized, .limited, .notDetermined:
                    return continuation.resume(returning: true)
                @unknown default:
                    return continuation.resume(returning: false)
                }
            }
        }
    }
}
