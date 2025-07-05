//
//  UserDetailModel.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 02/07/25.
//

import Foundation

struct UserDetailModel: Decodable, Hashable {
    let login: String
    let id: Int
    let avatarURL: String
    let url, htmlURL: String
    let followersURL, followingURL: String
    let reposURL: String
    let type, userViewType: String
    let name: String?
    let location, email: String?
    let bio: String?
    let followers, following: Int
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
        case type
        case userViewType = "user_view_type"
        case name, location, email, bio
        case followers, following
    }
}

extension UserDetailModel {
    init(id: Int, login: String, avatarUrl: String, name: String, bio: String?) {
        self.init(login: login, id: id, avatarURL: avatarUrl, url: "", htmlURL: "", followersURL: "", followingURL: "", reposURL: "", type: "", userViewType: "", name: name, location: "", email: "", bio: bio, followers: 0, following: 0)
    }
}
