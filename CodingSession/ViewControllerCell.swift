//
//  ViewControllerCell.swift
//  CodingSession
//
//  Created by Andrii Kvashuk on 13/05/2024.
//

import UIKit

class ViewControllerCell: UICollectionViewCell {
    private let thumbImageView: UIImageView = UIImageView(frame: .zero)
    private let durationLabel: UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        
        contentView.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
    
    func set(image: UIImage, title: String) {
        self.thumbImageView.image = image
        self.durationLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

