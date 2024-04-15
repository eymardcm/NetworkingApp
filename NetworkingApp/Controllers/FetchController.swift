//
//  FetchController.swift
//  NetworkingApp
//
//  Created by Chad Eymard on 4/14/24.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badUrl
        case badResponse
    }
    
    private let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // 1. Build a url
        let quoteURL = baseUrl.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        
        // 1a. Construct query parameters
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceStringWithPlus)
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchURL = quoteComponents?.url else {
            throw NetworkError.badUrl
        }
        
        // 2. Make a request to an api
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        
        // 3. Validate the response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        // 4. Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 5. Create a property for the decoded data
        guard let quote = try? decoder.decode(Quote.self, from: data) else {
            fatalError("Failed to decode \(response) from \(fetchURL).")
        }
        
        // 6: Return the ready-to-use data
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        // 1. Build a url
        let characterURL = baseUrl.appending(path: "characters")
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        
        // 1a. Construct query parameters
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceStringWithPlus)
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchURL = characterComponents?.url else {
            throw NetworkError.badUrl
        }
        
        // 2. Make a request to an api
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        
        // 3. Validate the response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        // 4. Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 5. Create a property for the decoded data
        guard let characters = try? decoder.decode([Character].self, from: data) else {
            fatalError("Failed to decode \(response) from \(fetchURL).")
        }
        
        // 6: Return the ready-to-use data
        return characters[0]
    }
}
