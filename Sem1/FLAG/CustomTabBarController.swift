import UIKit

class CustomTabBarController: UIViewController {

    var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the initial view controller (LoginpageController)
        showViewController(viewController: LoginpageController())
    }
    
    func showViewController(viewController: UIViewController) {
        // Remove the current view controller from the parent
        currentViewController?.removeFromParent()
        currentViewController?.view.removeFromSuperview()
        
        // Add the new view controller to the container
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: self)
        
        currentViewController = viewController
    }
}
