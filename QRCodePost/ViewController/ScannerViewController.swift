//
//  ScannerViewController.swift
//  QRCodePost
//
//  Created by Genuine on 06.08.2021.
//

import Alamofire
import AVFoundation
import Combine
import SnapKit
import UIKit

@available(iOS 13.0, *)
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ObservableObject {
    var service = QRPostService()
    @Published var qrCode: String?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scannerSetup()

        requestCaptureSessionStartRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scanCompleted(withCode code: String) {
        service.postCode(code: code)
        qrCode = code
        print(code)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(ResultViewController(), animated: true, completion: nil)
        }
    }

    private var captureSession: AVCaptureSession?

    private func scannerSetup() {
        guard let captureSession = createCaptureSession() else {
            return
        }

        self.captureSession = captureSession

        let cameraView = view
        let previewLayer = createPreviewLayer(withCaptureSession: captureSession,
                                              view: cameraView!)
        cameraView!.layer.addSublayer(previewLayer)
    }

    private func createCaptureSession() -> AVCaptureSession? {
        do {
            let captureSession = AVCaptureSession()
            guard let captureDevice = AVCaptureDevice.default(for: .video) else {
                return nil
            }

            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            let metaDataOutput = AVCaptureMetadataOutput()

            // Add device input
            if captureSession.canAddInput(deviceInput) && captureSession.canAddOutput(metaDataOutput)
            {
                captureSession.addInput(deviceInput)
                captureSession.addOutput(metaDataOutput)

                let viewController = self
                metaDataOutput.setMetadataObjectsDelegate(viewController,
                                                          queue: DispatchQueue.main)
                metaDataOutput.metadataObjectTypes = metaObjectTypes()

                return captureSession
            }
        } catch {
            // Handle error
        }

        return nil
    }

    private func createPreviewLayer(withCaptureSession captureSession: AVCaptureSession,
                                    view: UIView) -> AVCaptureVideoPreviewLayer
    {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill

        return previewLayer
    }

    private func metaObjectTypes() -> [AVMetadataObject.ObjectType] {
        return [.qr,
                .code128,
                .code39,
                .code39Mod43,
                .code93,
                .ean13,
                .ean8,
                .interleaved2of5,
                .itf14,
                .pdf417,
                .upce,
        ]
    }

    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection)
    {
        requestCaptureSessionStopRunning()

        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let scannedValue = readableObject.stringValue

        else {
            return
        }

        scanCompleted(withCode: scannedValue)
    }

    public func requestCaptureSessionStartRunning() {
        toggleCaptureSessionRunningState()
    }

    public func requestCaptureSessionStopRunning() {
        toggleCaptureSessionRunningState()
    }

    private func toggleCaptureSessionRunningState() {
        guard let captureSession = self.captureSession else {
            return
        }

        if !captureSession.isRunning {
            print("Session is Running")
            captureSession.startRunning()
        } else {
            print("Session stopRunning")
            captureSession.stopRunning()
        }
    }
}
