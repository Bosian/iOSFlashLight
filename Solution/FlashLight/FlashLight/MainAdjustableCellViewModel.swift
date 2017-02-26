//
//  MainAdjustableCellViewModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

struct MainAdjustableCellViewModel {
    
    let model: MainModel
    
    let title: String
    
    var value: Float {
        didSet {
            if value != oldValue {
                let oldValue = min(1.0, max(0.1, oldValue))
                let newValue = min(1.0, max(0.1, value))
                
                isValueHandler(indexPath, oldValue, newValue, self)
            }
        }
    }
    
    var isOn: Bool {
        didSet {
            if isOn != oldValue {
                isOnHandler(indexPath, oldValue, isOn, self)
            }
        }
    }
    
    let indexPath: IndexPath
    
    let isValueHandler: (_ indexPath: IndexPath, _ oldValue: Float, _ newValue: Float, _ viewModel: MainAdjustableCellViewModel) -> Void
    
    let isOnHandler: (_ indexPath: IndexPath, _ oldValue: Bool, _ newValue: Bool, _ viewModel: MainAdjustableCellViewModel) -> Void
    
    init(model: MainModel,
         title: String,
         value: Float,
         isOn: Bool,
         indexPath: IndexPath,
         isValueHandler: @escaping (_ indexPath: IndexPath, _ oldValue: Float, _ newValue: Float, _ viewModel: MainAdjustableCellViewModel) -> Void,
         isOnHandler: @escaping (_ indexPath: IndexPath, _ oldValue: Bool, _ newValue: Bool, _ viewModel: MainAdjustableCellViewModel) -> Void
        )
    {
        self.model = model
        self.title = title
        self.value = value
        self.isOn = isOn
        self.indexPath = indexPath
        self.isValueHandler = isValueHandler
        self.isOnHandler = isOnHandler
    }
}
