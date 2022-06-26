//
//  ViewController.swift
//  Weather
//
//  Created by Евгений Мизюк on 30.05.2022.
//

import UIKit

protocol PassDataDelegate {
    func passData(data: CityModel)
}

class CityViewController: UIViewController {
    
    public var delegate: PassDataDelegate?
    
    private var viewModel = CityViewModel()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        return tv
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.delegate = self
        sc.searchResultsUpdater = self
        sc.searchBar.placeholder = "Поиск"
        return sc
    }()
    
    private var isFiltering: Bool {
        return searchController.isActive && searchController.searchBar.text! != ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavController()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func configureNavController() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(addCity))
    }
    
    func getViewModelCityArrayCount() -> Int {
        return self.viewModel.cities.count
    }
    
    @objc func addCity() {
        let alertController = UIAlertController(title: "Город", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let alertAdd = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            let text = alertController.textFields?.first
            guard let city = text?.text else { return }
            self?.viewModel.getCityWeather(city: city) { [weak self] city in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            self?.tableView.reloadData()
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default)
        alertController.addAction(alertAdd)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension CityViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.viewModel.filteredCities = self.viewModel.cities.filter {
            return $0.name.lowercased().contains(searchController.searchBar.text!.lowercased())
        }
        self.tableView.reloadData()
    }
    
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.viewModel.filteredCities.count
        }
        return self.viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath)
        if isFiltering {
            cell.textLabel?.text = self.viewModel.filteredCities[indexPath.row].name
            return cell
        }
        cell.textLabel?.text = self.viewModel.cities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.passData(data: self.viewModel.cities[indexPath.row])
        self.tabBarController?.selectedIndex = 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, completionHandler in
            self?.viewModel.cities.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
