//
//  SpaceXDataRepositoryProtocol.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

protocol SpaceXDataRepositoryProtocol {
    typealias FetchCompletion = (Result<[Launch], Error>) -> Void
    
    func fetchLaunchData(completion: @escaping FetchCompletion)
}
