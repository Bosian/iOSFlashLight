//
//  Global.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

func print(_ items: Any...)
{
    #if DEBUG
        for item in items
        {
            print(item, separator: " ", terminator: "\n")
        }
    #endif
}
