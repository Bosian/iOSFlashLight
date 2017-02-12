//
//  InterfaceController.swift
//  FlashLight WatchKit Extension
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var watchScreenSwitch: WKInterfaceSwitch!
    @IBOutlet var phoneScreenSwitch: WKInterfaceSwitch!
    @IBOutlet var phoneFlashLightSwitch: WKInterfaceSwitch!
    
    var viewModel: InterfaceViewModel! {
        didSet {
            watchScreenSwitch.setOn(viewModel.isWatchScreenLight)
            phoneScreenSwitch.setOn(viewModel.isPhoneScreenLight)
            phoneFlashLightSwitch.setOn(viewModel.isPhoneFlashLight)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        viewModel = InterfaceViewModel()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func watchScreenHandler(_ value: Bool) {
        viewModel.isWatchScreenLight = !viewModel.isWatchScreenLight
    }
    
    @IBAction func phoneScreenHandler(_ value: Bool) {
        viewModel.isPhoneScreenLight = !viewModel.isPhoneScreenLight
    }
    
    @IBAction func phoneFlashLightHandler(_ value: Bool) {
        viewModel.isPhoneFlashLight = !viewModel.isPhoneFlashLight
    }

}
