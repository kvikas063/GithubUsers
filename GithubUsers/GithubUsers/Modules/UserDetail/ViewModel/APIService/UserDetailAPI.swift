//
//  UserDetailAPI.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

enum UserDetailAPI: APIEndpoint {
    case getUserDetail(id: String)
    case getUserRepos(id: String)

    var path: String {
        switch self {
            case .getUserDetail(let id):
                return "users/\(id)"
            case .getUserRepos(let id):
                return "users/\(id)/repos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getUserDetail, .getUserRepos:
                return .get
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
            case .getUserDetail:
                return nil
            case .getUserRepos:
                return nil
        }
    }
    
    var body: Data? {
        return nil
    }
}
