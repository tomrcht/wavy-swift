//
//  SettingsViewController.swift
//  Wavyswift
//
//  Created by Tom Rochat on 02/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
//    private let banner = Banner()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openBanner(_ sender: Any) {
//        banner.show(variant: .error)
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
