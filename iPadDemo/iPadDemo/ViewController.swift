//
//  ViewController.swift
//  iPadDemo
//
//  Created by Arron Zhu on 2017/7/18.
//  Copyright © 2017年 mrarronz. All rights reserved.
//

import UIKit
import QRCodeScanner

class ViewController: QRScannerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func customStyle() -> QRScannerStyle! {
        let style = QRScannerStyle.init()
        style.isNeedShowRectangle = true
        style.angleLineLength = 40
        style.angleColor = UIColor.init(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
        style.noneRecognizeColor = UIColor.black.withAlphaComponent(0.6)
        style.rectangleBorderColor = UIColor.white
        style.verticalOffset = 0
        style.marginOffset = 300
        
        return style
    }
    
    override func rectOfInterest() -> CGRect {
        return QRScannerHelper.getInterestRect(in: self.view, style: self.customStyle())
    }

    // MARK: - handle result
    override func handleScanResult() {
        
    }

}

