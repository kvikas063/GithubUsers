//
//  UserDetailViewModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

final class UserDetailViewModel {
    
    // MARK: - Private Properties
    private(set) var userDetailModel: UserDetailModel?
    private(set) var userRepos: [UserRepositoryModel] = []
    
    private let networkService: NetworkService
    private(set) var userID: String

    // MARK: - Init Method
    init(networkService: NetworkService, id: String) {
        self.userID = id
        self.networkService = networkService
    }

    // MARK: - Fetch API Methods
    func fetchUserDetails() async {
        await fetchUserDetail()
        await fetchRepositories()
    }
}

// MARK: - Private Fetch API Request Methods
private extension UserDetailViewModel {
    
    func fetchUserDetail() async {
        let result: Result<UserDetailModel, Error> = await networkService.request(endpoint: UserDetailAPI.getUserDetail(id: userID))
        switch result {
            case .success(let user):
                self.userDetailModel = user
                debugPrint("## Fetched User Detail - Success!")
            case .failure(let error):
                debugPrint("## Failed with error: ", error)
        }
    }
    
    func fetchRepositories() async {
        let result: Result<[UserRepositoryModel], Error> = await networkService.request(endpoint: UserDetailAPI.getUserRepos(id: userID))
        switch result {
            case .success(let repos):
                self.userRepos = repos
                debugPrint("Fetched Repos - Success!")
            case .failure(let error):
                debugPrint("## Failed with error: ", error)
        }
    }
}
