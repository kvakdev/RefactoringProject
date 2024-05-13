//
//  ViewController.swift
//  CodingSession
//
//  Created by Pavel Ilin on 01.11.2023.
//

import UIKit
import RxSwift
import SnapKit
import Accelerate
import Photos
import RxCocoa

class ViewController: UIViewController {
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var settingsButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.title = "Go to settings and allow access to videos"
        
        let button = UIButton(configuration: config, primaryAction: .init(handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        
        return button
    }()
    
    lazy var dataSource = GalleryCollectionViewDataSource(collectionView: collectionView, itemSize: UIConstants.itemSize)
    let viewModel: GalleryViewModel
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: GalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSettingsButton()
        
        viewModel.cellControllers.observe(on: MainScheduler()).subscribe { [weak self] controllers in
            self?.dataSource.set(cellControllers: controllers)
        }
        .disposed(by: disposeBag)
        
        viewModel.settingsButtonHidden.bind(to: self.settingsButton.rx.isHidden).disposed(by: self.disposeBag)
        
        viewModel.start()
    }
    
    private func setupSettingsButton() {
        view.addSubview(settingsButton)
        
        settingsButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.register(ViewControllerCell.self, forCellWithReuseIdentifier: "ViewControllerCell")
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }
}
