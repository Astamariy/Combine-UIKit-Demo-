//
//  LocationListView.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import SwiftUI
import Combine

struct LocationListView: View {
    
    // MARK: - Private properties
    
    @ObservedObject private var observable: LocationListObservableObject
    
    // MARK: - Initialization
    
    init(viewModel: LocationListViewModelProtocol) {
        self.observable = LocationListObservableObject(viewModel: viewModel)
    }
    
    // MARK: - Protocol properties
    
    var body: some View {
        ZStack {
            List(observable.locations) { location in
                LocationListCell(model: location)
                    .onTapGesture {
                        observable.didSelectLocation.send(location)
                    }
            }
            ActivityIndicator(isAnimating: .constant(observable.isLoading), style: .large)
        }
    }
    
}
