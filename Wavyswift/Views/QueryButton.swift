//
//  QueryButton.swift
//  Wavyswift
//
//  Created by Tom Rochat on 27/11/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class QueryButton: UIButton {
    override func awakeFromNib() {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor(named: "PrimaryColor")?.cgColor

        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)

        titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    }
}
