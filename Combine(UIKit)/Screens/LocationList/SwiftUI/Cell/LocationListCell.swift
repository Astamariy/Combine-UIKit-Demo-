//
//  LocationListCell.swift
//  Combine(UIKit)
//
//  Created by Рузманов Александр Юрьевич on 18.04.2022.
//

import SwiftUI

struct LocationListCell: View {
    
    // MARK: - Private properties
    
    @ObservedObject private var observable: LocationListCellObservableObject
    
    // MARK: - Initialization
    
    init(model: LocationCellModel) {
        self.observable = LocationListCellObservableObject(model: model)
    }
    
    // MARK: - Protocol properties
    
    var body: some View {
        HStack {
            ZStack {
                Color.gray
                Image(uiImage: observable.icon)
                    .resizable()
            }
            .cornerRadius(20)
            .frame(width: 100, height: 100)
            
            Text(observable.name)
        }
    }
    
}
