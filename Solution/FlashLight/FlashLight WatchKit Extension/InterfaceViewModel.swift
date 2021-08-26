//
//  InterfaceViewModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import WatchConnectivity

struct InterfaceViewModel: MutatingClosure {
    
    weak var binder: Binder?
    var isUpdate: Bool = false
    
    var model: MainModel = MainModel() {
        didSet {
            
            guard !isUpdate else {
                return
            }
            
            isUpdate = true
            
            let copySelf = self
            
            WCSession.default.activate()
            
            WCSession.default.sendMessage(model.toDictionary(), replyHandler: { (jsonDictionary) in
                print(jsonDictionary)
                
                // UI Thread
                DispatchQueue.main.async {
                    guard var mutatingSelf = copySelf.closureForViewModel() else {
                        return
                    }
                    
                    mutatingSelf.isUpdate = false
                    
                    copySelf.setClosure(for: mutatingSelf)
                }
                
            }) { (error) in
                print(error)
                
                // UI Thread
                DispatchQueue.main.async {
                    guard var mutatingSelf = copySelf.closureForViewModel() else {
                        return
                    }
                    
                    mutatingSelf.isUpdate = false
                    
                    copySelf.setClosure(for: mutatingSelf)
                }
            }
        }
    }
    
    init(binder: Binder)
    {
        self.binder = binder
    }
}
