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
    
    private func runEditProfile() {
        let controller = makeEditProfile()
        router.push(controller)
    }
}

extension MSettingsCoordinator {
    private func makeSettings() -> BaseViewControllerProtocol {
        let navigation = MSettingsNavigation {
            self.runEditProfile()
        }
        return MSettingsViewController(navigation: navigation)
    }
    
    private func makeEditProfile() -> BaseViewControllerProtocol {
        return MProfileViewController()
    }
}
