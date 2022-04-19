//
//  SWULocationView.swift
//  Combine(UIKit)
//
//  Created by Рудаков Евгений on 18.04.2022.
//

import Foundation
import SwiftUI
import Combine

struct SWULocationView: View {
    
    // MARK: - Typealias
    
    typealias ViewModel = SWULocationViewModel
    
    // MARK: - Constants
    
    private enum Constants {
        static let locationDescriptionStackViewSpacing = CGFloat(16)
        static let contentStackViewSpacing = CGFloat(16)
        static let contentStackViewInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let locationImageViewSize = CGSize(width: 100, height: 100)
        static let buttonHeight = CGFloat(56)
    }
    
    // MARK: - Private properties
    
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Protocol properties
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: Constants.contentStackViewSpacing) {
                HStack(alignment: .center, spacing: Constants.locationDescriptionStackViewSpacing) {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .frame(
                            width: Constants.locationImageViewSize.width,
                            height: Constants.locationImageViewSize.height
                        )
                    Text(viewModel.name)
                }
                Button("tap me", action: viewModel.buttonTap)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    
            }
            .padding()
        }
        .background(Color.blue)
    }
}
