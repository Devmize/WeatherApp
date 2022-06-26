//
//  MainCityTableCollectionViewCell.swift
//  Weather
//
//  Created by Евгений Мизюк on 25.06.2022.
//

import UIKit
import SnapKit

class MainCityTableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(self.timeLabel)
        contentView.addSubview(self.degreesLabel)
        contentView.addSubview(self.weatherImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layouts()
    }
    
    private func layouts() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
        degreesLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
        weatherImage.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.size.height / 3)
            make.height.equalTo(contentView.frame.size.height / 3)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    public func configure(model: Hourly) {
        self.timeLabel.text = getHours(time: model.dt)
        self.degreesLabel.text = String(Int(model.temp)) + "°"
        self.weatherImage.image = UIImage(named: model.weather[0].icon)
    }
    
    private func getHours(time: Int) -> String {
        let newTime = Double(time)
        let date = Date(timeIntervalSince1970: newTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: date)
    }
}
