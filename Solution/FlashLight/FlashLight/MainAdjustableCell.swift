//
//  MainCell.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

/// 可調整的Cell
class MainAdjustableCell: UITableViewCell, Binder, Viewer {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var flashSwitch: UISwitch!
    
    typealias ViewModelType = MainAdjustableCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            titleLabel.text = viewModel.title
            slider.value = viewModel.value
            flashSwitch.isOn = viewModel.isOn
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
    
    @IBAction func sliderHandler(_ sender: UISlider) {
        viewModel.value = sender.value
    }
    
    @IBAction func flashSwitchHandler(_ sender: UISwitch) {
        viewModel.isOn = sender.isOn
    }
}
