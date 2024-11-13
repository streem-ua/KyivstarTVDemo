//
//  AssetDetailsSimilarItemView.swift
//  DemoApp
//
//  Created by Vlad Tkach on 19.08.2024.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct AssetDetailsSimilarItemView: View {
    
    let item: ContentGroup.Asset
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading){
            WebImage(url: URL(string: item.image)) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
            }
            .resizable()
            .scaledToFit()
            Group {
                if !item.purchased {
                    Image.init(.homeVideoLocked)
                        .frame(width: 24.0, height: 24.0).offset(x: 8.0, y: 8.0)
                }
                if item.progress != 0 {
                    ProgressView(value: Double(item.progress)/100.0)
                        .frame(height: 4.0).offset(y: 152.0)
                }
            }
        }.scaledToFit()
        .frame(height: 156.0)
        .cornerRadius(12.0)
    }
}
