//
//  NavigationAction.swift
//  DemoApp
//
//  Created by Ihor on 06.08.2024.
//

typealias FlowActionCallback = ((FlowAction) -> Void)

enum FlowAction {
    case itemSelected(Home.Item)
}
