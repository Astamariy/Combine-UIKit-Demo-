//
//  ActivityIndicator.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    
    // MARK: - Public properties

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style
    
    // MARK: - Public methods

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
