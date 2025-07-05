//
//  SearchModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

struct SearchModel: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let users: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case users = "items"
    }
}

extension SearchModel {
    init(users: [UserModel]) {
        self.init(totalCount: users.count, incompleteResults: false, users: users)
    }
}
