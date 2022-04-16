import UIKit
import Combine

final class LocationsViewController: UIViewController, ViewModelBindable {
    
    // MARK: - TypeAlias
    
    typealias ContentView = LocationsView
    typealias Unit = LocationsViewUnit
    typealias ViewModel = Unit.ViewModel
    private typealias Cell = SomeLocationTableViewCell
    typealias CellModel = Unit.CellModel
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    private lazy var contentView = ContentView()
    private let refreshControl = UIRefreshControl()
    private weak var activityIndicatorView: UIActivityIndicatorView?
    private var dataSource = [CellModel]() {
        didSet { contentView.tableView.reloadData() }
    }
    private let becomeRefreshing = PassthroughSubject<Void, Never>()
    private let tableViewSelectedIndexPath = PassthroughSubject<IndexPath, Never>()
    
    // MARK: - Public properties
    
    var viewModel: ViewModel?
}

// MARK: - Life cycle

extension LocationsViewController {

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {
            preconditionFailure("viewModel must be assigned before viewDidLoad")
        }
        commonInit()
        bind(viewModel: viewModel)
    }
}

// MARK: - Implement ViewModelBindable

extension LocationsViewController {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input(
            update: becomeRefreshing.eraseToAnyPublisher(),
            selectedIndex: tableViewSelectedIndexPath.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input: input)
        
        subscriptions = [
            output.navigationBarTitle.assign(to: \.title, on: navigationItem),
            output.dataSource.assign(to: \.dataSource, on: self),
            output.showActivity.sink(receiveValue: { [unowned self] in showActivityIndicator(value: $0) }),
            output.empty.sink(receiveValue: {})
        ]
    }
    
    private func showActivityIndicator(value: Bool) {
        activityIndicatorView?.removeFromSuperview()
        guard value else { return }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - Common init

private extension LocationsViewController {
    func commonInit() {
        contentView.tableView.run {
            $0.dataSource = self
            $0.delegate = self
            $0.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
            $0.refreshControl = refreshControl
        }
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh(sender:)), for: .valueChanged)
    }
    
    // MARK: - Handle actions
    
    @objc func handlePullToRefresh(sender: UIRefreshControl) {
        becomeRefreshing.send(())
    }
}

// MARK: - Implement UITableViewDataSource

extension LocationsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataSource.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let identifier = String(describing: Cell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
        let model = dataSource[indexPath.row]
        cell.bind(viewModel: model)
        return cell
    }
}

// MARK: - Implement UITableViewDelegate

extension LocationsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableViewSelectedIndexPath.send(indexPath)
    }
}
