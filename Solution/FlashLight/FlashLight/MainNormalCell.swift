//
//  MainCell.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/18.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

class MainNormalCell: UITableViewCell, Binder, Viewer {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flashSwitch: UISwitch!
    
    typealias ViewModelType = MainNormalCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            titleLabel.text = viewModel.title
            flashSwitch.isOn = viewModel.isOn
            titleLabel.textColor = viewModel.model.isPhoneScreenLight ? .black : .white
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
    
    @IBAction func flashSwitchHandler(_ sender: UISwitch) {
        viewModel.isOn = sender.isOn
    }
}
