//  
//  LoginViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation
import Combine

protocol LoginViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class LoginViewModelImpl: LoginViewModel {
    
    //MARK: - Public Properties
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: AuthManager
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: AuthManager) {
        self.service = service
    }
    
    //MARK: - Public Methods
        
    
    
    //MARK: - Private Methods
    
}


