//
//  OTAUpdateController.swift
//  QMacro
//
//  Created by hukaiyin on 2021/7/6.
//  Copyright © 2021 sunday. All rights reserved.
//

import UIKit

class OTAUpdateController: UIViewController {

    let deviceName = LEDSDKCaller.deviceName
    
    @objc func testTUI() {
        LEDSDKCaller.startOTA(data: data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "测试界面"
        testBtn.addTarget(self, action: #selector(testTUI), for: .touchUpInside)
        contentLabel.text = deviceName + "\n" + dataText
    }
    
    private lazy var contentLabel: UILabel = {
        let l = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 100))
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(l)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    lazy var testBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 320, width: view.frame.width, height: 100))
        view.addSubview(btn)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("升级", for: .normal)
        return btn
    }()
    
    var data = Data()
    var dataText = ""
}
