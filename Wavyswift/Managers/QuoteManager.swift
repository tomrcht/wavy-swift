//
//  QuoteManager.swift
//  Wavyswift
//
//  Created by Tom Rochat on 25/11/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import Foundation

class QuoteManager {
    private let apiUrl = "https://api.kanye.rest/"

    func fetchQuote(completion: @escaping (Result<Quote, Error>) -> Void) -> Void {
        guard let url = URL(string: apiUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
                return
            }

            if let data = data {
                do {
                    let quote = try JSONDecoder().decode(Quote.self, from: data)
                    completion(.success(quote))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
