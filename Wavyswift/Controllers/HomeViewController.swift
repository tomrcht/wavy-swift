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

    private var spinner = UIActivityIndicatorView()
    private var quoteManager = QuoteManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.color = .red
        spinner.center = CGPoint(x: quoteLabel.frame.size.width / 2, y: quoteLabel.frame.size.height / 2)
    }

    @IBAction func getQuote(_ sender: Any) {
        prepareForQuery()

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
            self.didTerminateQuery()
        }
    }

    private func didReceiveError(error: Error) {
        print(error)
        didTerminateQuery()
    }
}

extension HomeViewController {
    private func prepareForQuery() {
        spinner.startAnimating()
        quoteLabel.text = ""
        quoteLabel.addSubview(spinner)
    }

    private func didTerminateQuery() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}

