//
//  SettingsViewController.swift
//  Wavyswift
//
//  Created by Tom Rochat on 02/12/2019.
//  Copyright © 2019 Tom Rochat. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    private let banner = Banner()

    private let emitter = CAEmitterLayer()
    private let colors: [UIColor] = [
        UIColor(named: "PrimaryColor")!,
        UIColor(red: 64 / 255, green: 1, blue: 230 / 255, alpha: 1),
        UIColor(red: 156 / 255, green: 64 / 255, blue: 1, alpha: 1),
    ]
    private let images: [UIImage] = [
        UIImage(named: "Box")!,
        UIImage(named: "Spiral")!,
        UIImage(named: "Circle")!,
        UIImage(named: "Triangle")!,
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emitter.emitterPosition = CGPoint(x: view.center.x, y: -10.0)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        view.layer.addSublayer(emitter)
    }

    @IBAction func openBanner(_ sender: Any) {
        banner.show("This is a test message", variant: .info)
    }

    @IBAction func showParticles(_ sender: Any) {
        emitter.emitterCells = makeCells()
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func makeCells() -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()

        for _ in 0..<15 {
            let cell = CAEmitterCell()
            cell.birthRate = 2.0
            cell.lifetime = 10.0
            cell.velocity = CGFloat(Int.random(in: 90...150))
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 5.0
            cell.color = self.colors.randomElement()?.cgColor
            cell.contents = self.images.randomElement()?.cgImage
            cell.scale = 0.1
            cell.scaleRange = 0.25

            cells.append(cell)
        }
        return cells
    }

}
