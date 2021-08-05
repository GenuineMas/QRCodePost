//
//  Scannner.swift
//  QRCodePost
//
//  Created by Genuine on 06.08.2021.
//

import Alamofire
import Combine
import Foundation

@available(iOS 13.0, *)

class QRPostService: ObservableObject {
    @Published var QRCodeResult: String?
    var result = ResponseServer()

    func postCode(code: String) {
        let url = URL(string: "https://httpbin.org/post")!
        AF.request(url, method: .post, parameters: ["QR": code], encoder: JSONParameterEncoder.default)
            .validate()
            .responseJSON { [weak self] response in
                let decoder = JSONDecoder()
                if let jsonQRCode = try? decoder.decode(QRCode.self, from: response.data!) {
                    resultQR.qrResult = jsonQRCode.json.values.first
                    self!.QRCodeResult = jsonQRCode.json.values.first!
                    print("QRCodeResult(postcode) : ", self!.QRCodeResult)
                }
            }
    }
}
