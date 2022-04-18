//
//  LocationListContainerViewController.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import SwiftUI
import SnapKit
import UIKit
import Combine

final class LocationListContainerViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Public properties
    
    var viewModel: LocationListViewModelProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }
    
}

// MARK: - Private methods

private extension LocationListContainerViewController {
    
    func setupUI() {
        let hostingViewController = LocationListConfigurator.configure(viewController: self)
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
        hostingViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func binding() {
        viewModel.titlePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] title in
                self.title = title
            })
            .store(in: &subscriptions)
    }
}
