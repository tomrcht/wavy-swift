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
    @IBOutlet weak var mainLogo: UIImageView!
    
    private var spinner = UIActivityIndicatorView()
    private var quoteManager = QuoteManager()

    private var initialLogoPosition: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.color = UIColor(named: "TextColor")
        spinner.center = CGPoint(x: quoteLabel.frame.size.width / 2, y: quoteLabel.frame.size.height / 2)

        initialLogoPosition = mainLogo.frame
        mainLogo.isUserInteractionEnabled = true

        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.onLogoSwipeUp))
        upGesture.direction = .up
        mainLogo.addGestureRecognizer(upGesture)

        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.onLogoSwipeDown))
        downGesture.direction = .down
        mainLogo.addGestureRecognizer(downGesture)

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.onDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        mainLogo.addGestureRecognizer(doubleTap)
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

        DispatchQueue.main.async {
            self.didTerminateQuery()
        }
    }
}

private extension HomeViewController {
    private func prepareForQuery() {
        wavyButton.isEnabled = false

        spinner.startAnimating()
        quoteLabel.text = ""
        quoteLabel.addSubview(spinner)
    }

    private func didTerminateQuery() {
        wavyButton.isEnabled = true

        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}

private extension HomeViewController {
    @objc func onLogoSwipeUp(_ sender: UISwipeGestureRecognizer) -> Void {
        let x = mainLogo.frame.origin.x
        let y = mainLogo.frame.origin.y

        guard y - 50 >= 0 else {
            return
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.mainLogo.frame = CGRect(x: x, y: y - 50, width: self.mainLogo.frame.width, height: self.mainLogo.frame.height)
        }, completion: nil)
    }

    @objc func onLogoSwipeDown(_ sender: UISwipeGestureRecognizer) -> Void {
        let x = mainLogo.frame.origin.x
        let y = mainLogo.frame.origin.y

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.mainLogo.frame = CGRect(x: x, y: y + 50, width: self.mainLogo.frame.width, height: self.mainLogo.frame.height)
        }, completion: nil)
    }

    @objc func onDoubleTap(_ sender: UITapGestureRecognizer) -> Void {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.mainLogo.frame = self.initialLogoPosition
        }, completion: nil)
    }
}

internal extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue" {
            guard let destination = segue as? SettingsViewController else {
                return
            }
            // ...
        }
    }
}
