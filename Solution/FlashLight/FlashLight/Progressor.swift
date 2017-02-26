//
//  Progressor.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/26.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

protocol Progressor: class, Viewer {
    
    associatedtype ViewModelType: Updateable
    
    func showProgressIfNeeded()
}

extension Progressor {
    
    func showProgressIfNeeded() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = viewModel.isUpdate
    }
}
