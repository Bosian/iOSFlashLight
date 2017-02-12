//
//  MainViewModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

struct MainViewModel {
    var isFlashLight: Bool = false {
        didSet {
            Utilities.isPhoneFlashOn = isFlashLight
        }
    }
    
}
