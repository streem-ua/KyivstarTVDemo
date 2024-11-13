//
//  Platform.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 26.08.2024.
//

import UIKit
import NetworkLayer

final class Platform: UseCasesProvider {
    // MARK: - Public Properties
    let assets: AssetsUseCases
    
    // MARK: - Private Properties
    private let network: Network
    private let authPlugin: AuthorizationPlugin
    
    // MARK: - Initialize
    init() {
        let token = Token(tokenString: Environment.current.bearerToken)
        authPlugin = AuthorizationPlugin()
        authPlugin.setToken(token)
        network = Network(baseURL: Environment.current.baseURL, plugins: [authPlugin, APIErrorPlugin()])
        assets = AssetsService(network: network)
    }
    
    // MARK: - AppDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
}
