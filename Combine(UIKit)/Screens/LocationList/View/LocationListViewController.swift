//
//  LocationListViewController.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import UIKit
import Combine

final class LocationListViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Public properties
    
    var viewModel: LocationListViewModelProtocol!
    
    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationListConfigurator.configure(viewController: self)
        binding()
    }

}

// MARK: - Private methods

private extension LocationListViewController {
    
    func binding() {
        viewModel.titlePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] title in
                self.title = title
            })
            .store(in: &subscriptions)
        
        viewModel.locationsPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] locations in
                tableView.reloadData()
            })
            .store(in: &subscriptions)
        
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] isLoading in
                if isLoading {
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.stopAnimating()
                }
            })
            .store(in: &subscriptions)
    }
}

// MARK: - UITableViewDataSource

extension LocationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LocationTableViewCell.self), for: indexPath)
        (cell as? LocationTableViewCell)?.update(model: viewModel.locations[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension LocationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectLocationAtIndexPath.send(indexPath)
    }
    
}
