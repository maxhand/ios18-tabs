import UIKit

class ViewController: UIViewController { }

extension ViewController {
	static func makeWithBackgroundColor(_ backgroundColor: UIColor, title: String) -> UIViewController {
		let viewController = ViewController()
		
		viewController.title = title
		viewController.view.backgroundColor = backgroundColor
		
		return viewController
	}
}
