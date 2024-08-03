import UIKit

class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()

		self.mode = .tabSidebar
	}
}

extension TabBarController {
	static func makeTabBarController() -> TabBarController {
		let tabBarController = TabBarController()
		
		tabBarController.tabs = [
			.init(
				title: "First",
				image: UIImage(systemName: "1.circle"),
				identifier: "First Tab"
			) {
				return ViewController.makeWithBackgroundColor(.systemBlue, title: "\($0.title)")
			},
			.init(
				title: "Second",
				image: UIImage(systemName: "2.circle"),
				identifier: "Second Tab"
			) {
				return ViewController.makeWithBackgroundColor(.systemGreen, title: "\($0.title)")
			},
			.init(
				title: "Third",
				image: UIImage(systemName: "3.circle"),
				identifier: "Third Tab"
			) {
				return ViewController.makeWithBackgroundColor(.systemOrange, title: "\($0.title)")
			},
			makeTabGroup(),
			UISearchTab { _ in
				UINavigationController(
					rootViewController: ViewController.makeWithBackgroundColor(.systemMint, title: "Search")
				)
			}
		]
		
		return tabBarController
	}
	
	private static func makeTabGroup() -> UITabGroup {
		return UITabGroup(
			title: "First Section",
			image: .init(systemName: "book"),
			identifier: "First Section",
			children: [
				UITab(
					title: "Grouped Tab 1",
					image: UIImage(systemName: "1.circle"),
					identifier: "Grouped Tab 1"
				) {
					return ViewController.makeWithBackgroundColor(.systemBrown, title: "\($0.title)")
				},
				UITab(
					title: "Grouped Tab 2",
					image: UIImage(systemName: "2.circle"),
					identifier: "Grouped Tab 2"
				) {
					return ViewController.makeWithBackgroundColor(.systemTeal, title: "\($0.title)")
				},
				UITab(
					title: "Grouped Tab 3",
					image: UIImage(systemName: "3.circle"),
					identifier: "Grouped Tab 3"
				) {
					return ViewController.makeWithBackgroundColor(.systemYellow, title: "\($0.title)")
				},
			]) { _ in
				return ViewController.makeWithBackgroundColor(.systemIndigo, title: "Default")
			}
	}
}
