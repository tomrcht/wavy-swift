//
//  ViewController.swift
//  Wavyswift
//
//  Created by Tom Rochat on 25/11/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, QuoteManagerDelegate {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var wavyButton: UIButton!

    private var quoteManager = QuoteManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        quoteManager.delegate = self
    }

    @IBAction func getQuote(_ sender: Any) {
        quoteManager.fetchQuote()
    }

    func didReceiveQuote(_ manager: QuoteManager, quote: Quote) {
        quoteLabel.text = quote.quote
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

