//
//  ScannerViewController.swift
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
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate,ObservableObject {
    
    private var scanner: Scanner?
    var viewModel = QRViewModel()
    @Published var qrCode : String?
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scanner = Scanner(withDelegate: self)
        guard let scanner = self.scanner else {
            return
        }
        scanner.requestCaptureSessionStartRunning()
      
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - AVFoundation delegate methods

    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        guard let scanner = self.scanner else {
            return
        }
        scanner.metadataOutput(output,
                               didOutput: metadataObjects,
                               from: connection)
    }

    // MARK: - Scanner delegate methods

    func cameraView() -> UIView {
        return view
    }

    func delegateViewController() -> UIViewController {
        return self
    }
    
    
    func scanCompleted(withCode code: String) {
        
        viewModel.postCode(code: code)
        qrCode = code
        print(code)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(ResultViewController(), animated: true, completion: nil)
        }
    }
}
