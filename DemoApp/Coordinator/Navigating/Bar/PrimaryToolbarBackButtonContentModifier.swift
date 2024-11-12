//
//  PrimaryToolbarBackButtonContentModifier.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct PrimaryToolbarBackButtonContentModifier: ViewModifier {
    // MARK: - Properties
    private var backAction: (() -> Void)?
    // MARK: - Init
    init(backAction: (() -> Void)?) {
        self.backAction = backAction
    }
    // MARK: - Main View
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                PrimaryToolbarBackButtonContent {
                    backAction?()
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}
