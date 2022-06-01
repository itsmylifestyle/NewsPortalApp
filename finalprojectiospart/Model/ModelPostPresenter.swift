//
//  SwiftUIViewPostPresenter.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI
import Foundation

struct ModelPostPresenter: Identifiable {
    let id = UUID()
    let title: String
    
    init(with model: ModelPost) {
        self.title = model.title
    }
}
