//
//  AsyncTask.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Combine

typealias AsyncTask<T> = AnyPublisher<T, AppError>
