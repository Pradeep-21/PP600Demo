//
//  MainController.swift
//  LEDSDKExample
//
//  Created by hukaiyin on 2023/2/27.
//

import UIKit
import LEDSDK

class MainController: UIViewController {
    
    // MARK: - actions
    
    @objc func scan() {
        LEDSDKCaller.scan()
    }
    
    @objc func messages() {
        LEDSDKCaller.messages()
    }
    
    @objc func animation() {
        guard let images = UIImage.images(from: "buzzlightyear") else {
            return
        }
        play(images: images, mode: .ppt) // 播放动画时，mode 必须为 .ppt
    }
    
    @objc func image() {
        
        guard let image = UIImage(named: "Charmander") else {
            return
        }
        
        play(images: [image], mode: .down)
    }
    
    func play(images: [UIImage], mode: EffectMode) {
        // app 应传入与设备 宽高比 相同的图片, 先裁剪
        var cropedImages = [UIImage]()
        for image in images {
            if LEDSDKCaller.column > LEDSDKCaller.row {
                cropedImages.append(image.clipped(size: CGSize(width: image.size.width, height: image.size.width / CGFloat(LEDSDKCaller.column) * CGFloat(LEDSDKCaller.row))))
            } else {
                cropedImages.append(image.clipped(size: CGSize(width: image.size.height / CGFloat(LEDSDKCaller.row) * CGFloat(LEDSDKCaller.column), height: image.size.height)))
            }
        }
                
        // 裁剪后播放
        LEDSDKCaller.play(images: cropedImages, x: LEDSDKCaller.column, y: LEDSDKCaller.row, animationKeepTime: 200, mode: mode, colorDepth: LEDSDKCaller.colorDepth)
    }
    
    @objc func text() {
        
        if LEDSDKCaller.column != 64 || LEDSDKCaller.row != 64 {
            // 示例字体宽高为 64 × 64，对应 64 × 64 的设备，如果设备宽高与字体不符，请找到相符的字体传入
            fatalError("示例字体宽高与设备不符或未获取设备宽高")
        }
        let fontData = Data.data(with: "64×64", ofType: "DZK")
        DataHelper.play(string: "测试文字", fontData: fontData, fontWidth: 64, fontHeight: 64, fontColors: [.white], mode: .up, keepTime: 220)
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        table.isHidden = false
        
        LEDSDKCaller.scan()
    }
    
    lazy var table: UITableView = {
        let t = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(t)
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        t.backgroundColor = .white
        return t
    }()
    
    var actions: [[String: Selector]] = [
        ["Scan->Connnect": #selector(scan)],
        ["基本信息": #selector(messages)],
        ["下发图片": #selector(image)],
        ["下发动画": #selector(animation)],
        ["下发文字": #selector(text)],
    ]
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        perform(actions[indexPath.row].values.first!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = actions[indexPath.row].keys.first
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
