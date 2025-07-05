//
//  MockUserListNetworkService.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

@testable import GithubUsers

final class MockUserListNetworkService: NetworkService {
    
    var shouldReturnError = false
    var mockUsers: [UserModel] = []
    var mockSearchResult: SearchModel = SearchModel(totalCount: 0, incompleteResults: false, users: [])
    
    func request<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, Error> {
        if shouldReturnError {
            return .failure(MockError.mockFailure)
        }
        
        if T.self == [UserModel].self, let users = mockUsers as? T {
            return .success(users)
        }
        
        if T.self == SearchModel.self, let searchModel = mockSearchResult as? T {
            return .success(searchModel)
        }
        
        return .failure(MockError.invalidMock)
    }
    
    enum MockError: Error {
        case mockFailure
        case invalidMock
    }
}
