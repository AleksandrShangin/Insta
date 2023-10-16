//  
//  EditProfileViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation
import Combine

protocol EditProfileViewModel {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class EditProfileViewModelImpl: EditProfileViewModel {
    
    //MARK: - Public Properties
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: DatabaseService
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: DatabaseService) {
        self.service = service
    }
    
    //MARK: - Public Methods
        
    
    
    //MARK: - Private Methods
    
}


