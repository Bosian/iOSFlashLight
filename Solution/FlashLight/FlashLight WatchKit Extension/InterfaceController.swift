//
//  InterfaceController.swift
//  FlashLight WatchKit Extension
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, Viewer, Binder {

    @IBOutlet var group: WKInterfaceGroup!
    @IBOutlet var watchScreenSwitch: WKInterfaceSwitch!
    @IBOutlet var phoneScreenSwitch: WKInterfaceSwitch!
    @IBOutlet var phoneFlashLightSwitch: WKInterfaceSwitch!
 
    var lightColor: UIColor = .white
    var darkColor: UIColor = UIColor(red: 0, green: 1 / 255.0, blue: 0, alpha: 1.0)
    
    typealias ViewModelType = InterfaceViewModel
    var viewModel: ViewModelType! {
        didSet {
            watchScreenSwitch.setOn(viewModel.model.isWatchScreenLight)
            phoneScreenSwitch.setOn(viewModel.model.isPhoneScreenLight)
            phoneFlashLightSwitch.setOn(viewModel.model.isPhoneFlashLight)
            
            // 顏色
            let backgroundColor = viewModel.model.isWatchScreenLight ? lightColor : darkColor
            let textColor = viewModel.model.isWatchScreenLight ? darkColor : lightColor
            group.setBackgroundColor(backgroundColor)
            
            let attributes = [NSForegroundColorAttributeName : textColor]
            watchScreenSwitch.setAttributedTitle(NSAttributedString(string: "手錶螢幕", attributes: attributes))
            phoneScreenSwitch.setAttributedTitle(NSAttributedString(string: "手機螢幕", attributes: attributes))
            phoneFlashLightSwitch.setAttributedTitle(NSAttributedString(string: "手機手電筒", attributes: attributes))
        }
    }
    
    var dataContext: Any? {
        get {
            return viewModel
        }
        
        set {
            viewModel = newValue as! ViewModelType
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let wcSession = WCSession.default()
        wcSession.delegate = self
        wcSession.activate()
        
        viewModel = InterfaceViewModel(binder: self)
    }
    
    @IBAction func watchScreenHandler(_ value: Bool) {
        viewModel.model.isWatchScreenLight = !viewModel.model.isWatchScreenLight
    }
    
    @IBAction func phoneScreenHandler(_ value: Bool) {
        viewModel.model.isPhoneScreenLight = !viewModel.model.isPhoneScreenLight
    }
    
    @IBAction func phoneFlashLightHandler(_ value: Bool) {
        viewModel.model.isPhoneFlashLight = !viewModel.model.isPhoneFlashLight
    }

}

// MARK: - 手機與手錶溝通
extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationState: \(activationState), \r\nerror: \(error)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
//        guard !viewModel.isUpdate else {
//            return
//        }
        
        print("Watch: \(message)")
        
        let newModel = MainModel(jsonDictionary: message)
        
        guard viewModel.model != newModel else {
            replyHandler(viewModel.model.toDictionary())
            return
        }
        
        // UI Thread
        DispatchQueue.main.async { [weak self] in
            
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.viewModel.model = newModel
            replyHandler(weakSelf.viewModel.model.toDictionary())
        }
    }
}
