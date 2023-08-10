//
//  LaunchListViewModel.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

enum LaunchNameFilter {
    case ascName
    case descName
}


class LaunchListViewModel: LaunchListViewModelProtocol {
    private let fetchLaunchesUseCase: FetchLaunchesUseCaseProtocol
    var filter: LaunchNameFilter = .ascName
    var launches: [Launch] = [] {
        didSet {
            onLaunchUpdate?()
        }
    }
    
    var onLaunchUpdate: (() -> Void)?
    var didSelectLaunch: ((Launch) -> Void)?
    
    init(fetchLaunchesUseCase: FetchLaunchesUseCaseProtocol) {
        self.fetchLaunchesUseCase = fetchLaunchesUseCase
    }
    
    func fetchLaunches() {
        fetchLaunchesUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let launches):
                self.launches = {
                    switch self.filter {
                    case .ascName:
                        return launches.sorted { $0.launchSite.siteName.uppercased() < $1.launchSite.siteName.uppercased() }
                    case .descName:
                        return launches.sorted { $0.launchSite.siteName.uppercased() > $1.launchSite.siteName.uppercased() }
                    }
                }()
            case .failure(let error):
                print("Failed to fetch recipes: \(error)")
            }
        }
    }
    
    func didSelectLaunch(at index: Int) {
        let selectedRecipe = launches[index]
        didSelectLaunch?(selectedRecipe)
    }
}
