//
//  NetworkService.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

/// Protocol for Network Requests
protocol NetworkService {
    func request<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, Error>
}
