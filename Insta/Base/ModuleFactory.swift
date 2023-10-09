//
//  ModuleFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import Foundation

protocol ModuleFactory {
    associatedtype ViewController
    func build() -> ViewController
}
