//
//  PHomeVM.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine

protocol PHomeVM: ViewModel where Input: PHomeVMInput, Output: PHomeVMOutput {}

// MARK: - Input
protocol PHomeVMInput {
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    var didDeleteSection: PassthroughSubject<HomeViewAdapter.SectionType, Never> { get }
    var didBeginRefreshing: PassthroughSubject<Void, Never> { get }
    var didSelectAsset: PassthroughSubject<Void, Never> { get }
}

// MARK: - Output
protocol PHomeVMOutput {
    var sectionData: AnyPublisher<[SectionData], Never> { get }
    var onDeleteSection: AnyPublisher<HomeViewAdapter.SectionType, Never> { get }
    var viewStateOutput: AnyPublisher<HomeVM.ViewState, Never> { get }
}
