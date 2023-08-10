//
//  FetchLaunchesUseCaseProtocol.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

protocol FetchLaunchesUseCaseProtocol {
    typealias Completion = (Result<[Launch], Error>) -> Void
    
    func execute(completion: @escaping Completion)
}
