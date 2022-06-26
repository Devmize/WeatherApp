//
//  MainCityTableViewCell.swift
//  Weather
//
//  Created by Евгений Мизюк on 26.06.2022.
//

import UIKit
import SnapKit

class MainCityTableViewCell: UITableViewCell {

    static let identefier = "TableViewCell"
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var rangeDegreesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layouts()
    }
    
    private func setup() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(rangeDegreesLabel)
        contentView.addSubview(weatherImage)
    }
    
    private func layouts() {
        timeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        rangeDegreesLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        weatherImage.snp.makeConstraints { make in
            make.width.equalTo(contentView.frame.size.height / 1.5)
            make.height.equalTo(contentView.frame.size.height / 1.5)
            make.left.equalTo(timeLabel).inset(25)
            make.centerY.equalToSuperview()
        }
    }
    
    public func configure(model: Daily?) {
        guard let model = model else { return }
        self.timeLabel.text = getDay(time: model.dt)
        self.descriptionLabel.text = model.weather[0].description
        self.rangeDegreesLabel.text = String(Int(model.temp.min)) + "°" + " - " + String(Int(model.temp.max)) + "°"
        self.weatherImage.image = UIImage(named: model.weather[0].icon)
    }
    
    private func getDay(time: Int) -> String {
        let newTime = Double(time)
        let date = Date(timeIntervalSince1970: newTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

}
