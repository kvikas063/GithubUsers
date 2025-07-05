//
//  APIEndpoints.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

/// API Endpoint `HTTP` methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more methods as needed (PUT, DELETE, etc.)
}

/// Protocol for API Endpoints
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    /// Set Base `URL` for the APIs
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    /// Creates `URL` with query parameters
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryParameters
        return components?.url
    }
}
