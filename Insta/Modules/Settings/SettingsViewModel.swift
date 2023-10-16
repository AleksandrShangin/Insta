//  
//  SettingsViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation
import Combine

protocol SettingsViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
    
    var logOutSuccess: CurrentValueSubject<Bool, Never> { get }
    
    func logOut()
}

final class SettingsViewModelImpl: SettingsViewModel {
    
    //MARK: - Public Properties
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    var logOutSuccess = CurrentValueSubject<Bool, Never>(false)
    
    //MARK: - Private Properties
    
    private let service: AuthService
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: AuthService) {
        self.service = service
    }
    
    //MARK: - Public Methods
    
    func logOut() {
        self.service.logOut { [weak self] success in
            if success {
                self?.logOutSuccess.send(true)
            }
        }
    }
    
    
    //MARK: - Private Methods
    
}


