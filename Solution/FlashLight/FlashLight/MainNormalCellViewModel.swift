//
//  MainNormalCellViewModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

struct MainNormalCellViewModel {
    
    let title: String
    
    var isOn: Bool {
        didSet {
            if isOn != oldValue {
                isOnHandler(indexPath, oldValue, isOn, self)
            }
        }
    }
    
    let indexPath: IndexPath
    
    let isOnHandler: (_ indexPath: IndexPath, _ oldValue: Bool, _ newValue: Bool, _ viewModel: MainNormalCellViewModel) -> Void
    
    init(title: String,
         isOn: Bool,
         indexPath: IndexPath,
         isOnHandler: @escaping (_ indexPath: IndexPath, _ oldValue: Bool, _ newValue: Bool, _ viewModel: MainNormalCellViewModel) -> Void
        )
    {
        self.title = title
        self.isOn = isOn
        self.indexPath = indexPath
        self.isOnHandler = isOnHandler
    }
}
