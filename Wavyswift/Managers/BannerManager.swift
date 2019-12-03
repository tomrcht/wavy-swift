//
//  BannerManager.swift
//  Wavyswift
//
//  Created by Tom Rochat on 02/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

final class BannerManager {
    private let bannerView = UIView()

    private let margin: CGFloat = 20.0
    private let height: CGFloat = 100.0

    private let initialPositionFrame: CGRect
    private let endPositionFrame: CGRect

    private var isShown: Bool = false
    private var content: UILabel = UILabel()

    private let window: UIWindow? = {
        if #available(iOS 13.0, *) {
            let foregroundScene = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let scene = foregroundScene as? UIWindowScene {
                return scene.windows.first ?? UIApplication.shared.delegate?.window ?? nil
            }
        }

        return UIApplication.shared.delegate?.window ?? nil
    }()

    init() {
        guard let window = self.window else {
            print("no window found")

            initialPositionFrame = .zero
            endPositionFrame = .zero
            return
        }

        let bounds = window.bounds
        initialPositionFrame = CGRect(x: bounds.minX + margin, y: bounds.maxY, width: bounds.width - margin * 2, height: height)
        endPositionFrame = CGRect(x: bounds.minX + margin, y: bounds.maxY - height * 2, width: bounds.width - margin * 2, height: height)

        bannerView.frame = initialPositionFrame
        bannerView.layer.cornerRadius = 4.0
        bannerView.backgroundColor = UIColor(named: "TextColor") ?? .red
    }

    public func show() -> Void {
        window!.addSubview(bannerView) // Cannot be in init() or else, it wont show above the settings page ????

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.bannerView.frame = self.endPositionFrame
        }) { finished in
            self.isShown = true
        }

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
//            self?.isShown = false
//
//            self?.bannerView.willMove(toWindow: nil)
//            self?.bannerView.removeFromSuperview()
//        }
    }
}
