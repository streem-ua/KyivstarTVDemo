//
//  CustomButtonStyle.swift
//  DemoApp
//
//  Created by Vlad Tkach on 19.08.2024.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let strokeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 2
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
                .offset(y: offset)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(strokeColor, lineWidth: 1))
                .offset(y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
                .compositingGroup()
                .shadow(radius: 6, y: 4)
        }
    }
}
