//
//  View + ext.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

extension View {
    func spinner(isShowing: Binding<Bool>) -> some View {
        self.modifier(SpinnerModifier(isShowing: isShowing))
    }
}
