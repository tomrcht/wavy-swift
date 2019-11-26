//
//  QuoteManager.swift
//  Wavyswift
//
//  Created by Tom Rochat on 25/11/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import Foundation

protocol QuoteManagerDelegate {
    func didReceiveQuote(_ manager: QuoteManager, quote: Quote)
    func didFailWithError(error: Error)
}

class QuoteManager {
    private let apiUrl = "https://api.kanye.rest/"
    var delegate: QuoteManagerDelegate?

    func fetchQuote() -> Void {
        // Testing the UILabel wrap
        delegate?.didReceiveQuote(self, quote: Quote(quote: "I am a very long fucking text that is gonna be a pain in your ass for days because you dont have enough size on your screen, peasant"))
    }
}
