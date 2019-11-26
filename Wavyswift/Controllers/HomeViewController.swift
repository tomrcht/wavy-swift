//
//  ViewController.swift
//  Wavyswift
//
//  Created by Tom Rochat on 25/11/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var wavyButton: UIButton!

    private var quoteManager = QuoteManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getQuote(_ sender: Any) {
        quoteManager.fetchQuote { (result) in
            switch result {
            case .success(let quote):
                self.setNewQuote(quote: quote)
            case .failure(let error):
                self.didReceiveError(error: error)
            }
        }
    }

    private func setNewQuote(quote: Quote) {
        DispatchQueue.main.async {
            self.quoteLabel.text = quote.quote
        }
    }

    private func didReceiveError(error: Error) {
        print(error)
    }
}

