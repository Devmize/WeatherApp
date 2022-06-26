//
//  MainCityCollectionTableViewCell.swift
//  Weather
//
//  Created by Евгений Мизюк on 25.06.2022.
//

import UIKit

class MainCityCollectionTableViewCell: UITableViewCell {
    
    static let identefier = "CollectionTableViewCell"

    private let collectionView: UICollectionView
    
    private var models: [Hourly] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MainCityTableCollectionViewCell.self, forCellWithReuseIdentifier: MainCityTableCollectionViewCell.identifier)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(models: [Hourly]) {
        self.models = models
        self.collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = contentView.bounds
    }
    
}

extension MainCityCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCityTableCollectionViewCell.identifier,
                                                      for: indexPath) as! MainCityTableCollectionViewCell
        cell.configure(model: model)
        return cell
    }
}
