//
//  MainModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/19.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

struct MainModel: JsonSerializeable, JsonDeserializeable, Equatable {
    
    var isWatchScreenLight: Bool = false
    var isPhoneScreenLight: Bool = false
    var isPhoneFlashLight: Bool = false
    
    public init()
    {
        
    }
    
    public static func ==(lhs: MainModel, rhs: MainModel) -> Bool {
        
        let isEqual = lhs.isWatchScreenLight == rhs.isWatchScreenLight &&
                     lhs.isPhoneScreenLight == rhs.isPhoneScreenLight &&
                     lhs.isPhoneFlashLight == rhs.isPhoneFlashLight
        
        return isEqual
    }
    
    public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
    {
        self.isWatchScreenLight = parseBool(value: jsonDictionary["isWatchScreenLight"])
        self.isPhoneScreenLight = parseBool(value: jsonDictionary["isPhoneScreenLight"])
        self.isPhoneFlashLight = parseBool(value: jsonDictionary["isPhoneFlashLight"])
    }
}
