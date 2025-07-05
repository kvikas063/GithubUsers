//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

/// A `URLSession` class for API calls
class NetworkManager: NetworkService {
    
    private let token: String?
    private let session: URLSession
    
    init(session: URLSession = .shared, token: String?) {
        self.session = session
        self.token = token
    }
    
    /// Calls API Endpoint with `URL`
    /// - Parameter endpoint: API `Endpoint`
    /// - Returns: ResultType `Decodable` response with `Error`
    func request<T: Decodable>(endpoint: APIEndpoint) async -> Result<T, Error> {
        // Create Request with APIEndpoint
        guard let request = RequestBuilder.build(for: endpoint, with: token)
        else {
            return .failure(NetworkError.invalidURL)
        }
        
        do {
            // Call API Request
            let (data, response) = try await session.data(for: request)
            
            // Check for URL Response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .failure(NetworkError.invalidResponse)
            }
            
            // Decode response and return success
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
            
        } catch {
            // Return failure
            return .failure(error)
        }
    }
}
