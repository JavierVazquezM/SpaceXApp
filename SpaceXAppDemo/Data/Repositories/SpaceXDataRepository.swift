//
//  SpaceXDataRepository.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Alamofire

class SpaceXDataRepository: SpaceXDataRepositoryProtocol {
    func fetchLaunchData(completion: @escaping FetchCompletion) {
        AF.request("https://api.spacexdata.com/v3/launches/past").responseDecodable(of: [Launch].self) { response in
            switch response.result {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
