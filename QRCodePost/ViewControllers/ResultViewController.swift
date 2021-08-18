//
//  ResultViewController.swift
//  QRCodePost
//
//  Created by Genuine on 05.08.2021.
//

import Alamofire
import AVFoundation
import UIKit
import SnapKit
import Combine

@available(iOS 13.0, *)

class ResultViewController: UIViewController {
    
    var codeResultView = UIView()
    var resultLabel = UILabel()
    var restartButton = UIButton()
    var responseServer = ResponseServer()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        result()
        setupResultView()

    }
    
    func result() {
        print(responseServer.$qrResult)
        resultQR.$qrResult.sink(receiveValue: { value in
            self.resultLabel.text = "QR code   \(value ?? "Text")"
            print("VALUE",value as Any)
        }).store(in: &cancellables)
    }
    
    func setupResultView() {
        
        view.addSubview((codeResultView))
        
        codeResultView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalToSuperview()
            make.center.equalTo(view)
        }
        codeResultView.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { (make) -> Void in
            
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(10)
            resultLabel.textColor = .black
            resultLabel.backgroundColor = .gray
            make.center.equalTo(view)
        }
        
        codeResultView.addSubview(restartButton)
        restartButton.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(10)
            make.bottom.equalTo(codeResultView.snp.bottom)
            make.center.equalToSuperview()
            restartButton.setTitle("Again", for: .normal)
            restartButton.tintColor = .green
        }
        
        restartButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("this is rootVC:",( UIApplication.shared.keyWindow?.rootViewController))
        self.dismiss(animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(ScannerViewController(), animated: true, completion: nil)
        }
}
