//
//  NetworkError.swift
//  GithubUsers
//
//  Created by Vikas Kumar on 01/07/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}
