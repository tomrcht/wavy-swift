//
//  Banner.swift
//  Wavyswift
//
//  Created by Tom Rochat on 05/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

enum BannerVariant {
    case info, success, warning, error
}

final class Banner: UIView {
    /*
     * Banner data
     */
    public private(set) var isShown: Bool = false
    public private(set) var variant: BannerVariant = .info

    /*
     * Banner frame / sizes
     */
    private let margin = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    private let padding = UIEdgeInsets(top: 5.0, left: 10, bottom: 5.0, right: 5.0)
    private let height: CGFloat = 50.0

    private let startingFrame: CGRect
    private let endingFrame: CGRect

    /*
     * Application window used to display the banner
     */
    private let appWindow: UIWindow = {
        if #available(iOS 13.0, *) {
            let foregroundScene = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let scene = foregroundScene as? UIWindowScene {
                return scene.windows.first!
            }
        }
        return UIApplication.shared.delegate!.window!!
    }()

    init() {
        let bounds = appWindow.bounds
        let safeAreaInsets = appWindow.safeAreaInsets
        let width = bounds.width - margin.left - margin.right
        startingFrame = CGRect(x: bounds.minX + margin.left, y: -height, width: width, height: height)
        endingFrame = CGRect(x: bounds.minX + margin.left, y: safeAreaInsets.top, width: width, height: height)

        super.init(frame: .zero)

        initViewStyle()
        initViewResponses()

        appWindow.addSubview(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show(variant: BannerVariant) -> Void {
        if isShown {
            print("Banner is already open")
            return
        }

        switch variant {
        case .success:
            backgroundColor = UIColor(red: 143 / 255, green: 217 / 255, blue: 136 / 255, alpha: 1)
        case .warning:
            backgroundColor = UIColor(red: 254 / 255, green: 125 / 255, blue: 80 / 255, alpha: 1)
        case .error:
            backgroundColor = UIColor(red: 253 / 255, green: 66 / 255, blue: 69 / 255, alpha: 1)
        case .info:
            backgroundColor = UIColor(named: "TextColor")
        }

        appWindow.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.frame = self.endingFrame
        }, completion: { finished in
            self.isShown = true
        })
    }

    private func initViewStyle() -> Void {
        clipsToBounds = true
        layer.cornerRadius = 4.0

        backgroundColor = UIColor(named: "TextColor")
    }

    private func initViewResponses() -> Void {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeUp))
        upGesture.direction = .up
        addGestureRecognizer(upGesture)
    }

    @objc private func onSwipeUp(_ sender: Any?) -> Void {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.frame = self.startingFrame
        }, completion: { finished in
            self.isShown = false
        })
    }
}
