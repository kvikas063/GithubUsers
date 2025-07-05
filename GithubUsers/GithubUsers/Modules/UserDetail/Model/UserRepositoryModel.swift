//
//  UserRepositoryModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

struct UserRepositoryModel: Decodable, Hashable {
    let id: Int
    let name, fullName: String
    let htmlURL: String
    let description: String?
    let url: String
    let stargazersCount: Int
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case description, url
        case stargazersCount = "stargazers_count"
        case language
    }
}

extension UserRepositoryModel {
    init(id: Int, name: String, description: String?) {
        self.init(id: id, name: name, fullName: "", htmlURL: "", description: description, url: "", stargazersCount: 0, language: "")
    }
}
