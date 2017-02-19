//
//  MainViewModel.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import WatchConnectivity

struct MainViewModel: MutatingClosure {
    
    weak var binder: Binder?
    var isUpdate: Bool = false
    
    var cellViewModels: [RowTypes] = []
    var model = MainModel() {
        didSet {
            
            guard !isUpdate else {
                return
            }
            
            isUpdate = true
            
            updateCell(model: model)
            
            let copySelf = self
            
            WCSession.default().activate()
            WCSession.default().sendMessage(model.toDictionary(), replyHandler: { (jsonDictionary) in
                print(jsonDictionary)
                
                // UI Thread
                DispatchQueue.main.async {
                    guard var mutatingSelf = copySelf.closureForViewModel() else {
                        return
                    }
                    
                    mutatingSelf.isUpdate = false
                    
                    copySelf.setClosure(for: mutatingSelf)
                }
                
            }, errorHandler: { (error) in
                print(error)
                
                // UI Thread
                DispatchQueue.main.async {
                    guard var mutatingSelf = copySelf.closureForViewModel() else {
                        return
                    }
                    
                    mutatingSelf.isUpdate = false
                
                    copySelf.setClosure(for: mutatingSelf)
                }
            })
        }
    }
    
    init(binder: Binder)
    {
        self.binder = binder
        
        Utilities.isPhoneFlashOn = false
        
        updateCell(model: model)
    }
    
    private mutating func updateCell(model: MainModel) {
        
        let copySelf = self
        
        Utilities.isPhoneScreenOn = model.isPhoneScreenLight
        Utilities.isPhoneFlashOn = model.isPhoneFlashLight
        
        self.cellViewModels = [
            
            .normal(
                MainNormalCellViewModel(
                    title: "手錶螢幕",
                    isOn: model.isWatchScreenLight,
                    indexPath: IndexPath(row: 0, section: 0),
                    isOnHandler: { (indexPath, oldValue, newValue, cellViewModel) in
                        
                        guard var mutatingSelf = copySelf.closureForViewModel() else {
                            return
                        }
                        
                        mutatingSelf.model.isWatchScreenLight = newValue
                        
                        copySelf.setClosure(for: mutatingSelf)
                    }
                )
            ),
            
            .normal(
                MainNormalCellViewModel(
                    title: "手機螢幕",
                    isOn: model.isPhoneScreenLight,
                    indexPath: IndexPath(row: 1, section: 0),
                    isOnHandler: { (indexPath, oldValue, newValue, cellViewModel) in
                        
                        guard var mutatingSelf = copySelf.closureForViewModel() else {
                            return
                        }
                        
                        mutatingSelf.model.isPhoneScreenLight = newValue
                        
                        copySelf.setClosure(for: mutatingSelf)
                    }
                )
            ),
            
            .adjustable(
                MainAdjustableCellViewModel(
                    title: "手機手電筒",
                    value: 1,
                    isOn: model.isPhoneFlashLight,
                    indexPath: IndexPath(row: 2, section: 0),
                    isValueHandler: { (indexPath, oldValue, newValue, cellViewModel) -> Void in
                        
                        // 手電筒開關
                        let isOnOldValue = cellViewModel.isOn
                        let isOnNewValue = newValue > 0.0
                        
                        cellViewModel.isOnHandler(indexPath, isOnOldValue, isOnNewValue, cellViewModel)
                    },
                    isOnHandler: { (indexPath, oldValue, newValue, cellViewModel) -> Void in
                        guard var mutatingSelf = copySelf.closureForViewModel() else {
                            return
                        }
                        
                        mutatingSelf.model.isPhoneFlashLight = newValue
                        
                        copySelf.setClosure(for: mutatingSelf)
                    }
                )
            )
        ]
    }
}

extension MainViewModel {
    
    /**
     Cell類型
     
     - shopName:      店名
     - largeCategory: 大類別
     */
    enum RowTypes: StringConvertable, ValueRepresentable {
        
        case adjustable(MainAdjustableCellViewModel)
        case normal(MainNormalCellViewModel)
        
        func toString() -> String
        {
            switch self{
            case .adjustable(_):
                return "adjustable"
                
            case .normal(_):
                return "normal"
            }
            
        }
        
        typealias ValueType = Any?
        var value: ValueType {
            
            switch self{
            case .adjustable(let value):
                return value
                
            case .normal(let value):
                return value
            }
        }
    }
}
