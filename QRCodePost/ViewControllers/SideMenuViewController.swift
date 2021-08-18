//
//  ViewController.swift
//  QRCodePost
//
//  Created by Genuine on 04.07.2021.
//

import UIKit
import SwiftUI
import SnapKit

class SideMenuViewController: UIViewController {

    let sideMenuView = UIHostingController(rootView: ContentView())
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(sideMenuView)
        view.addSubview(sideMenuView.view)
        makeConstraints()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func makeConstraints(){
        sideMenuView.view.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}

