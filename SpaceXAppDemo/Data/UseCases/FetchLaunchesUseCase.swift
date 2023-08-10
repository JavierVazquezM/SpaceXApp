//
//  FetchLaunchesUseCase.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

class FetchLaunchesUseCase: FetchLaunchesUseCaseProtocol {
    private let launchesRepository: SpaceXDataRepositoryProtocol
    
    init(launchesRepository: SpaceXDataRepositoryProtocol) {
        self.launchesRepository = launchesRepository
    }
    
    func execute(completion: @escaping Completion) {
        launchesRepository.fetchLaunchData(completion: completion)
    }
}
