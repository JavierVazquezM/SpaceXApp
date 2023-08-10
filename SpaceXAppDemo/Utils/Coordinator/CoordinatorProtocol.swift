//
//  CoordinatorProtocol.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 07/08/23.
//

import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navController: UINavigationController { get set }
    
    func start()
}
