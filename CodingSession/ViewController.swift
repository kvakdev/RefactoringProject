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

class ViewController: UIViewController {
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        
        viewModel.cellControllers.observe(on: MainScheduler()).subscribe { [weak self] controllers in
            self?.dataSource.set(cellControllers: controllers)
        }
        .disposed(by: disposeBag)
        
        viewModel.requestSettings = { [weak self] in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Access denied", message: "Please go to settings and allow access to videos", preferredStyle: .actionSheet)
                let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                    self?.dismiss(animated: true) {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                }
                alert.addAction(settingsAction)
                
                self?.present(alert, animated: true)
            }
        }
        
        viewModel.start()
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
