//
//  ResultViewController.swift
//  QRCodePost
//
//  Created by Genuine on 05.08.2021.
//

import Combine
import Foundation
import UIKit

class ResultViewController: UIViewController {
    var resultView: ResultView {
        return view as! ResultView
    }

    var responseServer = ResponseServer()
    var cancellables: Set<AnyCancellable> = []

    override func loadView() {
        view = ResultView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        result()
        resultView.restartButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    func result() {
        print(responseServer.$qrResult)
        resultQR.$qrResult.sink(receiveValue: { value in
            self.resultView.resultLabel.text = "QR code   \(value ?? "Text")"
            print("VALUE", value as Any)
        }).store(in: &cancellables)
    }

    @objc func buttonAction(sender: UIButton!) {
        dismiss(animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(ScannerViewController(), animated: true, completion: nil)
    }
}
