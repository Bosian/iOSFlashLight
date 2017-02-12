//
//  Utilities.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import AVFoundation

public struct Utilities
{
    public static func openSafari(_ urlString: String) {
        
        guard let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            print("無法URL Encode, \(#function): urlString")
            return
        }
        
        guard let url = URL(string: urlEncoded) else {
            print("無法轉換成URL, \(#function): urlString")
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    /// 設定手機螢幕
    public static var isPhoneScreenOn: Bool {
        get {
            return UIScreen.main.brightness == 1.0
        }
        
        set {
            UIScreen.main.brightness = newValue ? 1.0 : 0.0
        }
    }
    
    /// 設定手機LED手電筒
    public static var isPhoneFlashOn: Bool {
        
        get
        {
            guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
            {
                return false
            }
            
            guard device.hasTorch else
            {
                return false
            }
            
            defer
            {
                device.unlockForConfiguration()
            }
            
            do
            {
                try device.lockForConfiguration()
                
                return device.torchMode == .on
            }
            catch let error
            {
                print(error.localizedDescription)
            }
            
            return false
        }
        
        set
        {
            guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
            {
                return
            }
            
            guard device.hasTorch else
            {
                return
            }
            
            defer
            {
                device.unlockForConfiguration()
            }
            
            do
            {
                try device.lockForConfiguration()
                
                if newValue
                {
                    try device.setTorchModeOnWithLevel(1.0)
                }
                else
                {
                    device.torchMode = .off
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
    }

}

