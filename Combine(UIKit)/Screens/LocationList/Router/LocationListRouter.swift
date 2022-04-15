//
//  LocationListRouter.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import Foundation
import Combine
import UIKit
import SafariServices

final class LocationListRouter: NSObject, Router {
    
    // MARK: - Private properties
    
    private weak var viewController: UIViewController!
    
    // MARK: - Initialization
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Protocol methods
    
    func navigate(to step: Step) {
        DispatchQueue.main.async { [weak self] in
            switch step {
            case let LocationListRouterStep.weather(url):
                self?.navigateToWeather(url: url)
            case let LocationListRouterStep.error(reloadSubject):
                self?.navigateToErrorAlert(reloadSubject: reloadSubject)
            default:
                break
            }
        }
    }
}

// MARK: - Private methods

private extension LocationListRouter {
    
    func navigateToErrorAlert(reloadSubject: PassthroughSubject<Void, Never>) {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить список локаций", preferredStyle: .alert)
        let repeatAction = UIAlertAction(title: "Повторить", style: .default) { [weak reloadSubject] _ in
            reloadSubject?.send(())
        }
        alert.addAction(repeatAction)
        
        viewController.present(alert, animated: true)
    }
    
    func navigateToWeather(url: String) {
        guard let url = URL(string: url) else {
            showWeatherAlert()
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        viewController.present(safariVC, animated: true)
    }
    
    func showWeatherAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить погоду для данной локации", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default))
        
        viewController.present(alert, animated: true)
    }
    
}

// MARK: - SFSafariViewControllerDelegate

extension LocationListRouter: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
    
}
