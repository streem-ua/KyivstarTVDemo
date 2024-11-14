//
//  ButtonModifier.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    var bgColor: ColorAssets
    var borderColor: ColorAssets
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .font(.custom(Font.semibold.rawValue, size: 16))
            .padding()
            .background(
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: geometry.size.height/2)
                        .stroke(lineWidth: 3)
                        .foregroundColor(borderColor.color())
                        .background(
                            RoundedRectangle(cornerRadius: geometry.size.height/2)
                                .foregroundColor(bgColor.color())
                                .shadow(color: bgColor.color(), radius: 0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
                        )
                }
            )
    }
}
