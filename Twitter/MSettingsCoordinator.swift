//
//  MSettingsCoordinator.swift
//  Twitter
//
//  Created by Vladimir on 04.05.2023.
//

import Foundation

import UIKit

final class MSettingsCoordinator: BaseCoordinator {    
    override func start() {
        let controller = makeSettings()
        router.setRootModule(controller)
    }
}

extension MSettingsCoordinator {
    private func makeSettings() -> BaseViewControllerProtocol {
        return MSettingsViewController()
    }
}
