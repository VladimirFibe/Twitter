import UIKit

final class FeedCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeFeed()
        router.setRootModule(controller)
    }
    
    private func runAddTweet() {
        let controller = makeAddTweet()
        controller.modalPresentationStyle = .fullScreen
        router.present(controller)
    }
}

extension FeedCoordinator {
    
    private func makeFeed() -> BaseViewControllerProtocol {
        let navigation = FeedNavigation(addTweetHandle: {
            self.runAddTweet()
        })
        return FeedViewController(navigation: navigation)
    }
    
    private func makeAddTweet() -> BaseViewControllerProtocol {
        return AddTweetViewController()
    }
}
