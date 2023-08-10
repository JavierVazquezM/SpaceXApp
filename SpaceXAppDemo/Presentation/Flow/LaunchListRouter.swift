//
//  LaunchListRouter.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import UIKit

protocol LaunchListRouterProtocol {
    func navigateToLaunchDetail(from viewController: UIViewController?, with launch: Launch)
}

class LaunchListRouter: LaunchListRouterProtocol {
    func navigateToLaunchDetail(from viewController: UIViewController?, with launch: Launch) {
        let launchDetailViewController = LaunchDetailsViewController(launch: launch)
        viewController?.navigationController?.pushViewController(launchDetailViewController, animated: true)
    }
}
