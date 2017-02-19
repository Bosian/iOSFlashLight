//
//  Utilities.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import AVFoundation

extension Utilities
{
    public static var oldPhoneScreenBrightness: CGFloat = UIScreen.main.brightness
    
    /// 設定手機螢幕
    public static var isPhoneScreenOn: Bool {
        get {
            return UIScreen.main.brightness == 1.0
        }
        
        set {
            if newValue {
                oldPhoneScreenBrightness = UIScreen.main.brightness
            }
            
            UIScreen.main.brightness = newValue ? 1.0 : oldPhoneScreenBrightness
        }
    }
    
    public static var phoneFlashValue: Float {
        get {
            guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
            {
                return 0.0
            }
            
            guard device.hasTorch else
            {
                return 0.0
            }
            
            defer
            {
                device.unlockForConfiguration()
            }
            
            do
            {
                try device.lockForConfiguration()
                
                return device.torchLevel
            }
            catch let error
            {
                print(error.localizedDescription)
            }
            
            return 0.0
        }
        
        set {
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
                try device.setTorchModeOnWithLevel(newValue)
            }
            catch
            {
                print(error.localizedDescription)
            }
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

