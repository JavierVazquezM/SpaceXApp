//
//  LaunchListViewController.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import UIKit

class LaunchListViewController: UIViewController {
    
    let tableView = UITableView()
    let cellIdentifier = "launchTableViewCell"
    var viewModel: LaunchListViewModelProtocol
    private var router: LaunchListRouterProtocol
    
    init(viewModel: LaunchListViewModelProtocol, router: LaunchListRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.onLaunchUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.didSelectLaunch = { [weak self] recipe in
            self?.router.navigateToLaunchDetail(from: self, with: recipe)
        }
        viewModel.fetchLaunches()
    }
    
    private func setupUI(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        configureMenu()
    }
    
    private func configureMenu() {
        var menuItems = [UIAction(title: "Asc Site",
                         image: nil,
                         handler: { (_) in
                             self.viewModel.filter = .ascName
                             self.viewModel.fetchLaunches()
                         }),
                         UIAction(title: "Desc Site",
                         image: nil,
                         handler: { (_) in
                             
                             self.viewModel.filter = .descName
                             self.viewModel.fetchLaunches()
                         })
            ]
        
        let filterMenu = UIMenu(title: "Order by",
                                image: nil,
                                identifier: nil,
                                options: [],
                                children: menuItems)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Order",
                                                            image: nil,
                                                            primaryAction: nil,
                                                            menu: filterMenu)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func bindViewModel() {
        viewModel.onLaunchUpdate = { [weak self] in
            self?.reloadData()
        }
    }
}

extension LaunchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(launch: viewModel.launches[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectLaunch(at: indexPath.row)
    }
}
