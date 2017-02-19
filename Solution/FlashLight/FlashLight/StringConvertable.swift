//
//  StringConvertable.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

protocol StringConvertable {
    func toString() -> String
}

extension StringConvertable {
    func toString() -> String {
        return "\(self)"
    }
}
