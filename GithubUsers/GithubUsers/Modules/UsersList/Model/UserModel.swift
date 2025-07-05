//
//  UserModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

struct UserModel: Decodable, Hashable {
    let login: String
    let id: Int
    let avatarURL: String
    let url, htmlURL: String
    let reposURL: String
    let type, userViewType: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case reposURL = "repos_url"
        case type
        case userViewType = "user_view_type"
    }
}

extension UserModel {
    init(id: Int, login: String) {
        self.init(login: login, id: id, avatarURL: "", url: "", htmlURL: "", reposURL: "", type: "", userViewType: "")
    }
}
