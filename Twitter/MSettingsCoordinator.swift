//
//  MSettingsCoordinator.swift
//  Twitter
//
//  Created by Vladimir on 04.05.2023.
//

import Foundation

import UIKit

final class MSettingsCoordinator: BaseCoordinator {
    weak var statusDelegate: MStatusProtocol?
    override func start() {
        let controller = makeSettings()
        router.setRootModule(controller)
    }
    
    private func runEditProfile() {
        let controller = makeEditProfile()
        router.push(controller)
    }
    
    private func runSelectStatus(_ status: Status) {
        let controller = makeSelectStatus(status)
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
        let navigation = MEditProfileNavigation { status in
            self.runSelectStatus(status)
        }
        let controller = MProfileViewController(navigation: navigation)
        statusDelegate = controller
        return controller
    }
    
    private func makeSelectStatus(_ status: Status) -> BaseViewControllerProtocol {
        let controller = MStatusViewController(status: status)
        controller.delegate = statusDelegate
        return controller
    }
}
