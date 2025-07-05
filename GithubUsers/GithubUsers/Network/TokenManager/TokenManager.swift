//
//  TokenManager.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 04/07/25.
//

import Foundation

/// Protocol to handle and manage token
protocol TokenProtocol {
    var token: String? { get }
    
    func updateToken(with token: String?)
    func clearToken()
}

/// Singleton class to handle and manage token
class TokenManager: TokenProtocol {
    
    static let shared = TokenManager()
    private init() {}

    private var accessToken: AccessToken?
    
    /// Get saved access token
    var token: String? {
        accessToken?.token
    }
    
    /// Updates token and create instance of `AccessToken`
    /// - Parameter token: login access token
    func updateToken(with token: String?) {
        self.accessToken = AccessToken(token: token)
    }
    
    /// Clears token after logout
    func clearToken() {
        self.accessToken = nil
    }
}
