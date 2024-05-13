//
//  SceneDelegate.swift
//  CodingSession
//
//  Created by Pavel Ilin on 01.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let vm = GalleryViewModel(videoProvider: VideoProvider(),
                                  cellWidth: UIConstants.itemSize.width,
                                  mapper: AssetMapper.map(asset:imageSize:))
        
        window.rootViewController = ViewController(viewModel: vm)
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

