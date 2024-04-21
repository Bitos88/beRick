//
//  URLSession.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

extension URLSession {
    func getData(from request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
