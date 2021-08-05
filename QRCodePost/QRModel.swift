//
//  QRModel.swift
//  QRCodePost
//
//  Created by Genuine on 05.08.2021.
//

import Foundation
import Combine

struct QRCode:Codable {
    var json : [String:String]
}

@available(iOS 13.0, *)
class ResponseServer:ObservableObject {
    
    @Published var qrResult : String?
    
}

@available(iOS 13.0, *)
 var resultQR = ResponseServer()
