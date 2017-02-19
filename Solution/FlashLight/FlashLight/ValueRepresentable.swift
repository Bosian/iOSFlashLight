//
//  ValueRepresentable.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

protocol ValueRepresentable {
    associatedtype ValueType
    var value: ValueType { get }
}
