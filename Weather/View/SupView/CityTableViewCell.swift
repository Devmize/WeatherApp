//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Евгений Мизюк on 24.06.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
