//
//  NetworkInteractor.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

protocol NetworkInteractorProtocol {
    var session: URLSession { get }
}

extension NetworkInteractorProtocol {
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat())
        
        let (data, response) = try await session.getData(from: request)
        if response.statusCode == 200 {
            do {
                return try decoder.decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
}
