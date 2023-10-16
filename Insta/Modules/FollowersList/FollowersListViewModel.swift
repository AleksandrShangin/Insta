//  
//  FollowersListViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation
import Combine

protocol FollowersListViewModel {
    var data: [UserRelationship] { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class FollowersListViewModelImpl: FollowersListViewModel {
    
    //MARK: - Public Properties
    
    let data: [UserRelationship]
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: DatabaseService
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(
        data: [UserRelationship],
        service: DatabaseService
    ) {
        self.data = data
        self.service = service
    }
    
    //MARK: - Public Methods
        
    
    
    //MARK: - Private Methods
    
}


