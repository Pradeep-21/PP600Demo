//
//  UIImage+ext.swift
//  LEDSDKExample
//
//  Created by hukaiyin on 2023/3/2.
//

import UIKit

// 示例用的 extension

extension UIImage {
    
     func clipped(size: CGSize) -> UIImage {
        let clippedImage = UIImage.init(cgImage: cgImage!.cropping(to: CGRect(x: 0, y: 0, width: size.width, height: size.height))!)
        return UIImage(cgImage: clippedImage.cgImage!, scale: clippedImage.scale, orientation: .up)
    }

    static func images(from gifName: String) -> [UIImage]? {
        
        guard let path = Bundle.main.path(forResource: gifName, ofType: "gif") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        var resultData: Data? = nil
        
        do {
            resultData = try Data(contentsOf: url)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
        
        guard let gifData = resultData,
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        
        var images = [UIImage]()
        
        for i in 0 ..< CGImageSourceGetCount(source) {
            guard let imageRef = CGImageSourceCreateImageAtIndex(source, i, nil) else { return nil }

            images.append(UIImage(cgImage: imageRef, scale: 1.0, orientation: .up))
        }
        
        return images
    }
    
}

extension Data {
    static func data(with fileName: String, ofType ext: String?) -> Data {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ext) else {
            fatalError("文件\(fileName)未找到")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        return data
    }
}
