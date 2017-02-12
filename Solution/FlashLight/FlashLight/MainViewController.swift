//
//  ViewController.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var flashLightSwitch: UISwitch!
    
    var viewModel: MainViewModel! {
        didSet {
            flashLightSwitch.isOn = viewModel.isFlashLight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.isPhoneFlashOn = false
        
        viewModel = MainViewModel()
    }
    
    /// 手電筒
    ///
    /// - Parameter sender: sender description
    @IBAction func flashLightHandler(_ sender: UISwitch) {
        viewModel.isFlashLight = !viewModel.isFlashLight
    }
}

