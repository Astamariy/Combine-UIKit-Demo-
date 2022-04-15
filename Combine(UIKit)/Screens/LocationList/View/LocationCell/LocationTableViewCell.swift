//
//  LocationTableViewCell.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 15.04.2022.
//

import UIKit
import Combine

final class LocationTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Outlets

    @IBOutlet private weak var iconImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        cancellables = Set<AnyCancellable>()
    }
    
    // MARK: - Public methods
    
    func update(model: LocationCellModel) {
        nameLabel.text = model.name
        model.icon
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.iconImageView.image = image
            })
            .store(in: &cancellables)
    }
    
}
