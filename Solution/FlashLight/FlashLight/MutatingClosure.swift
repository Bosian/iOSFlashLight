//
//  MutatingClosure.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

protocol MutatingClosure {
    
    weak var binder: Binder? { get set }
    
    func closureForViewModel() -> Self?
    func setClosure(for newValue: Self?)
}

extension MutatingClosure {
    
    func closureForViewModel() -> Self? {
        return binder?.dataContext as? Self
    }
    
    func setClosure(for newValue: Self?) {
        binder?.dataContext = newValue
    }
}
