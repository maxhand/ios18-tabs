import UIKit

private class TableViewCell: UITableViewCell {
	static let reuseId = String(describing: TableViewCell.self)
}

private enum TableViewSection: Hashable { case main }
private enum TableViewItem: Hashable {
	case first
	
	var title: String {
		switch self {
		case .first:
			"Centered Cell"
		}
	}
}

private class TableViewDataSource: UITableViewDiffableDataSource<TableViewSection, TableViewItem> { }

class TableViewController: UIViewController {
	private var dataSource: TableViewDataSource?
	private var tableView = UITableView(frame: .zero, style: .insetGrouped)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		showLoadingIndicator(true)
		makeDataSource()
		applySnapshot()
	}
	
	private func showLoadingIndicator(_ isShown: Bool) {
		if isShown {
			let activityIndicatorView = UIActivityIndicatorView()
			activityIndicatorView.startAnimating()
			
			tableView.backgroundView = activityIndicatorView
		} else {
			tableView.backgroundView = nil
		}
	}
	
	private func setupView() {
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
		
		view.addSubview(tableView)
		
		tableView.tableHeaderView = makeHeaderFooterViewTitled("Header View")
		tableView.tableFooterView = makeHeaderFooterViewTitled("Footer View")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor)
		])
	}
	
	private func makeHeaderFooterViewTitled(_ title: String) -> UIView {
		let label = UILabel(frame: .init(x: 0, y: 0, width: 0, height: 50))
		
		label.backgroundColor = .systemMint
		label.textAlignment = .center
		label.text = title
		
		return label
	}
	
	private func makeDataSource() {
		dataSource = TableViewDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
			let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId)
			
			var cellConfig = cell?.defaultContentConfiguration()
			
			cellConfig?.text = itemIdentifier.title
			cellConfig?.textProperties.alignment = .center
			
			cell?.contentConfiguration = cellConfig
			
			return cell
		})
	}
	
	private func applySnapshot(animatingDifferences: Bool = false) {
		var snapshot = NSDiffableDataSourceSnapshot<TableViewSection, TableViewItem>()
		
		snapshot.appendSections([TableViewSection.main])
		snapshot.appendItems([TableViewItem.first], toSection: .main)
		
		dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
	}
}
