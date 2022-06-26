//
//  MainCounrtyViewController.swift
//  Weather
//
//  Created by Евгений Мизюк on 17.06.2022.
//

import UIKit

class MainCityViewController: UIViewController {
    
    private let viewModel = MainCityViewModel()
    private let viewmodeltest = CityViewModel()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(MainCityTableViewCell.self, forCellReuseIdentifier: MainCityTableViewCell.identefier)
        tv.register(MainCityCollectionTableViewCell.self, forCellReuseIdentifier: MainCityCollectionTableViewCell.identefier)
        return tv
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(35)
        return label
    }()
    
    private lazy var degreesLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(50)
        return label
    }()
    
    private lazy var rangeOfDegreesLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(tableView)
    }
    
    private func configureHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width / 2))
        headerView.addSubview(cityNameLabel)
        headerView.addSubview(degreesLabel)
        headerView.addSubview(descriptionLabel)
        headerView.addSubview(rangeOfDegreesLabel)
        self.configureDataHeaderView()
        self.layoutsHeaderView()
        return headerView
    }
    
    private func layoutsHeaderView() {
        self.cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
        self.degreesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel).inset(35)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(degreesLabel).inset(55)
        }
        self.rangeOfDegreesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel).inset(35)
        }
    }
    
    private func configureDataHeaderView() {
        self.cityNameLabel.text = self.viewModel.city?.name
        self.degreesLabel.text = String(Int(self.viewModel.city?.temp ?? 0.0)) + "°"
        self.descriptionLabel.text = self.viewModel.city?.description
        self.rangeOfDegreesLabel.text = String(Int(self.viewModel.city?.weather.daily[0].temp.min ?? 0.0)) + "°" +
            " - " + String(Int(self.viewModel.city?.weather.daily[0].temp.max ?? 0.0)) + "°"
    }
    
    public func checkViewModelObjectForNil() -> CityModel? {
        guard let city = self.viewModel.city else { return nil }
        return city
    }

}

extension MainCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.viewModel.city?.weather.daily.count ?? 0) - 1) + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCityCollectionTableViewCell.identefier,
                                                     for: indexPath) as! MainCityCollectionTableViewCell
            cell.configure(models: self.viewModel.city?.weather.hourly ?? [])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCityTableViewCell.identefier,
                                                     for: indexPath) as! MainCityTableViewCell
            cell.configure(model: viewModel.city?.weather.daily[indexPath.row - 3] ?? nil)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 2: return 25
        case 1: return 100
        default: return 50
        }
    }
}

extension MainCityViewController: PassDataDelegate {
    
    func passData(data: CityModel) {
        self.viewModel.city = data
        self.viewModel.getWeatherData(city: data) { [weak self] city in
            DispatchQueue.main.async {
                self?.tableView.tableHeaderView = self?.configureHeaderView()
                self?.tableView.reloadData()
            }
        }
    }
}
