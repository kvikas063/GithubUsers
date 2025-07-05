//
//  MockUserDetailNetworkService.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import XCTest
@testable import GithubUsers

final class MockUserDetailNetworkService: NetworkService {
    
    var shouldReturnError = false
    var mockUserDetail: UserDetailModel = UserDetailModel(id: 1, login: "TestUser", avatarUrl: "", name: "Test User", bio: "Bio")
    var mockUserRepos: [UserRepositoryModel] = []
    
    func request<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, Error> {
        if shouldReturnError {
            return .failure(MockError.mockFailure)
        }
        
        if T.self == UserDetailModel.self, let user = mockUserDetail as? T {
            return .success(user)
        }
        
        if T.self == [UserRepositoryModel].self, let repos = mockUserRepos as? T {
            return .success(repos)
        }
        
        return .failure(MockError.invalidMock)
    }
    
    enum MockError: Error {
        case mockFailure
        case invalidMock
    }
}
