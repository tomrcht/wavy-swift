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
    private var label: UILabel = UILabel()
    private var timeBar: UIProgressView = UIProgressView(progressViewStyle: .bar)

    /*
     * Banner frame / sizes
     */
    private let margin = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 20.0)
    private let padding = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)

    private let startingFrame: CGRect
    private let endingFrame: CGRect

    /*
     * Application window used to display the banner
     */
    private lazy var appWindow: UIWindow? = {
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
        let bounds = UIScreen.main.bounds
        let width = bounds.width - margin.left - margin.right
        let height = 50.0 + padding.top + padding.bottom
        let x = bounds.minX + margin.left
        let y = -height

        startingFrame = CGRect(x: x, y: y, width: width, height: height)
        endingFrame = CGRect(x: x, y: 50.0, width: width, height: height)

        super.init(frame: .zero)

        initViewStyle()
        initViewResponses()
        initLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show(_ message: String, variant: BannerVariant) -> Void {
        guard !isShown else { return }
        guard message != "" else { return }

        label.text = message
        isShown = true
        setBackgroundColor(for: variant)

        appWindow?.addSubview(self)
        appWindow?.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.frame = self.endingFrame
        }, completion: { finished in
            self.isShown = true
        })
    }

    private func setBackgroundColor(for variant: BannerVariant) -> Void {
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

    private func initLabel() -> Void {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0

        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.left),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding.right),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    @objc private func onSwipeUp(_ sender: Any?) -> Void {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.frame = self.startingFrame
        }, completion: { finished in
            self.isShown = false
            self.removeFromSuperview()
        })
    }
}
