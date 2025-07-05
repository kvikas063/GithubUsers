//
//  RequestBuilder.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

struct RequestBuilder {
    
    /// Builds request using API endpoint URL and optional token
    /// - Parameters:
    ///   - endpoint: API `Endpoint`
    ///   - token: Optional API Access token
    /// - Returns: URLRequest
    static func build(
        for endpoint: APIEndpoint,
        with token: String?
    ) -> URLRequest? {
        guard let url = endpoint.url else { return nil }
        
        debugPrint("### API Endpoint URL: ", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
