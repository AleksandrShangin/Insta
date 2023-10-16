//  
//  RegistrationViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation
import Combine

protocol RegistrationViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
    
    func registerNewUser(username: String, email: String, password: String)
}

final class RegistrationViewModelImpl: RegistrationViewModel {
    
    //MARK: - Public Properties
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: AuthService
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: AuthService) {
        self.service = service
    }
    
    //MARK: - Public Methods
        
    func registerNewUser(username: String, email: String, password: String) {
        service.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                } else {
                    // failed
                }
            }
        }
    }
    
    //MARK: - Private Methods
    
}


