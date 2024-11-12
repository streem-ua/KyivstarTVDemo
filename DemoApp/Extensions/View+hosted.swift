//
//  View+hosted.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

extension View {
    var hosted: HostingController<Self> {
        HostingController<Self>(rootView: self)
    }
}
