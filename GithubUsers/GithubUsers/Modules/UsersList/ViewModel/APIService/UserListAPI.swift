//
//  UserListAPI.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

enum UserListAPI: APIEndpoint {
    case getUsers(since: Int)
    case searchUsers(value: String)
    
    var path: String {
        switch self {
            case .getUsers:
                return "users"
            case .searchUsers:
                return "search/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getUsers, .searchUsers:
                return .get
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
            case .getUsers(let since):
                return [
                    URLQueryItem(name: "since", value: "\(since)")
                ]
            case .searchUsers(let value):
                return [URLQueryItem(name: "q", value: value)]
        }
    }
    
    var body: Data? {
        return nil
    }
}
