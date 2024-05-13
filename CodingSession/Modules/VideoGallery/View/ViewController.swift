//
//  ViewController.swift
//  CodingSession
//
//  Created by Pavel Ilin on 01.11.2023.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class VideoGalleryController: UIViewController {

    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var settingsButton = UIButton.makeSettingsButton()
    private lazy var dataSource = GalleryCollectionViewDataSource(collectionView: collectionView, itemSize: UIConstants.itemSize)
    private let viewModel: VideoGalleryViewModel
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: VideoGalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
       
        viewModel.start()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupSettingsButton()
    }
    
    private func bind() {
        viewModel.cellControllers.observe(on: MainScheduler()).subscribe { [weak self] controllers in
            self?.dataSource.set(cellControllers: controllers)
        }
        .disposed(by: disposeBag)
        
        viewModel.settingsButtonHidden.bind(to: self.settingsButton.rx.isHidden).disposed(by: self.disposeBag)
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
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }
}
