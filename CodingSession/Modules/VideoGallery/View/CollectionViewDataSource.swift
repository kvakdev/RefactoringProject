//
//  CollectionViewDataSource.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import UIKit

class GalleryCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var cellControllers: [CellController] = []
    let collectionView: UICollectionView
    private let itemSize: CGSize
    
    init(collectionView: UICollectionView, itemSize: CGSize) {
        self.collectionView = collectionView
        self.itemSize = itemSize
    }
    
    func set(cellControllers: [CellController]) {
        self.cellControllers = cellControllers
        self.collectionView.register(type: ViewControllerCell.self)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ViewControllerCell = collectionView.dequeue(cellForItemAt: indexPath)
        let controller = cellControllers[indexPath.row]
        
        Task { @MainActor in
            let imageData = await controller.getImagePNGData()
            
            cell.set(image: UIImage(data: imageData) ?? UIImage(systemName: "photo.fill")!, title: controller.title)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
