//
//  PrimaryToolbarBackButtonContent.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct PrimaryToolbarBackButtonContent: ToolbarContent {
    // MARK: - Properties
    let backAction: () -> Void
    // MARK: - Main View
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(
                action: {
                    backAction()
                },
                label: {
                    Image.res.details.backButton
                }
            )
        }
    }
}
