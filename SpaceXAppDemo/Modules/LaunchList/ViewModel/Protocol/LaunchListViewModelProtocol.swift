//
//  LaunchListViewModelProtocol.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

protocol LaunchListViewModelProtocol {
    var launches: [Launch] { get }
    var filter: LaunchNameFilter { get set }
    var onLaunchUpdate: (() -> Void)? { get set }
    var didSelectLaunch: ((Launch) -> Void)? { get set }
    
    func fetchLaunches()
    func didSelectLaunch(at index: Int)
}
