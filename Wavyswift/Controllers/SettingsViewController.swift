//
//  SettingsViewController.swift
//  Wavyswift
//
//  Created by Tom Rochat on 02/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    private let manager = BannerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openBanner(_ sender: Any) {
        manager.show()
    }

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
