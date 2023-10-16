//  
//  ExploreViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation
import Combine

protocol ExploreViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class ExploreViewModelImpl: ExploreViewModel {
    
    //MARK: - Public Properties
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: DatabaseManager
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: DatabaseManager) {
        self.service = service
    }
    
    //MARK: - Public Methods
        
    
    
    //MARK: - Private Methods
    
}


