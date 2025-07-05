//
//  AccessToken.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//


import Foundation

struct AccessToken {
    let token: String?
    
    var isAuthenticated: Bool {
        return token != nil
    }
}