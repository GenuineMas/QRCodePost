//
//  ResultView.swift
//  QRCodePost
//
//  Created by Genuine on 05.08.2021.
//

import Alamofire
import AVFoundation
import Combine
import SnapKit
import UIKit

@available(iOS 13.0, *)

class ResultView: UIView {
    var resultLabel = UILabel()
    var restartButton = UIButton()

    init() {
        super.init(frame: CGRect.zero)
        initializeUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initializeUI() {
        addSubview(resultLabel)
        addSubview(restartButton)
        restartButton.setTitle("Again", for: .normal)
        restartButton.tintColor = .green
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .gray
    }

    func setupConstraints() {
        resultLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(10)
            make.center.equalToSuperview()
        }

        restartButton.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(10)
            make.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
