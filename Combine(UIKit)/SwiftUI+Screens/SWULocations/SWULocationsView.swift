//
//  SWULocationsView.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 19.04.2022.
//

import Foundation
import SwiftUI

struct SWULocationsView: View {
    
    // MARK: - Typealias
    
    typealias ViewModel = SWULocationsViewModel
    
    // MARK: - Private properties
    
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Protocol properties
    
    var body: some View {
        List(viewModel.dataSource) { model in
            SWULocationView(viewModel: model)
                .onTapGesture {
                    viewModel.didSelectItem(item: model)
                }
        }
    }
}
