//
//  UICollectionView+Ext.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import UIKit


extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: String(describing: type))
    }
}

