//
//  URLRequest.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

extension URLRequest {
    static func get(url: URL, params: [String: String] ) -> URLRequest {
        var request = URLRequest(url: url)
        params.forEach { key, value in
            request.url?.append(queryItems: [URLQueryItem(name: key, value: value)])
        }
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
