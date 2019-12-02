//
//  BannerManager.swift
//  Wavyswift
//
//  Created by Tom Rochat on 02/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class BannerManager {
    private lazy var window: UIWindow? = {
        let foregroundScene = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first

        if let scene = foregroundScene as? UIWindowScene {
            let firstWindow = scene.windows.first
            return firstWindow
        }
        return nil
    }()

    public func show() -> Void {
        guard let window = self.window else {
            print("no window")
            return
        }

        let bounds = window.bounds // UIScreen.main.bounds
        let frame = CGRect(x: bounds.minX + 20, y: bounds.minY, width: bounds.width - 40, height: CGFloat(200))
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 4.0
        view.backgroundColor = .black
        window.addSubview(view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak view] in
            guard let view = view else {
                return
            }
            view.removeFromSuperview()
        }
    }
}
