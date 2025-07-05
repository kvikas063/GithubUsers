//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

final class UserListViewModel {
    
    private let networkService: NetworkService
    
    // MARK: - Init Method
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Private Properties
    private(set) var users: [UserModel] = []
    private(set) var searchedUsers: [UserModel] = []
    private var currentPage: Int = 0
    
    // MARK: - Pagination Methods
    func resetPage() {
        currentPage = 0
        users = []
        searchedUsers = []
    }
    
    func updateNextPage() {
        currentPage = users.last?.id ?? 0
    }
}

// MARK: - Fetch API Request Methods
extension UserListViewModel {
    
    func fetchUsers() async -> Bool {        
        let result: Result<[UserModel], Error> = await networkService.request(endpoint: UserListAPI.getUsers(since: currentPage))
        switch result {
            case .success(let users):
                self.users.append(contentsOf: users)
                debugPrint("## Fetched Users - Success!")
                return true
            case .failure(let error):
                debugPrint("## Failed with error: ", error)
                return currentPage != 0
        }
    }
    
    func searchUsers(with query: String) async {
        let result: Result<SearchModel, Error> = await networkService.request(endpoint: UserListAPI.searchUsers(value: query))
        switch result {
            case .success(let response):
                debugPrint("## Fetched search users - Success!")
                self.searchedUsers = response.users
            case .failure(let error):
                debugPrint(error)
        }
    }
}

// MARK: - Setup Dummy Data for Unit Testing
extension UserListViewModel {
#if DEBUG
    func setupDummyData(users: [UserModel], searchedUsers: [UserModel], currentPage: Int) {
        self.users = users
        self.searchedUsers = searchedUsers
        self.currentPage = currentPage
    }
#endif
}
