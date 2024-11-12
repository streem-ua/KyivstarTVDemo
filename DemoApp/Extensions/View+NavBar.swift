//
//  View+NavBar.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

extension View {
    func primaryToolbar(backAction: (() -> Void)? = nil) -> some View {
        modifier(PrimaryToolbarBackButtonContentModifier(backAction: backAction))
    }
}
