//
//  DetailsFullDescriptionView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailsFullDescriptionView: View {
    // MARK: - Properties
    let model: AssetDetails
    let showOnlyTitle: Bool
    // MARK: - Init
    init(model: AssetDetails, showOnlyTitle: Bool = false) {
        self.model = model
        self.showOnlyTitle = showOnlyTitle
    }
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.init(hex: "2B3037"))
                .padding(.horizontal, 24)
            if !showOnlyTitle {
                Text(model.assetSubtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.init(hex: "313D54"))
                    .padding(.horizontal, 24)
                Text(model.description)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.init(hex: "808890"))
                    .padding(.horizontal, 24)
            }
        }
    }
}
