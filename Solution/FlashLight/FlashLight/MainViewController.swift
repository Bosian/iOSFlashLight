//
//  ViewController.swift
//  FlashLight
//
//  Created by 劉柏賢 on 2017/2/12.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit
import WatchConnectivity

final class MainViewController: UIViewController, Viewer, Binder, Progressor {

    @IBOutlet weak var tableView: UITableView!
    
    var defaultBackgroundColor: UIColor!
    
    typealias ViewModelType = MainViewModel
    var viewModel: ViewModelType! {
        didSet {
            showProgressIfNeeded()
            
            tableView.reloadData()
            
            if viewModel.model.isPhoneScreenLight
            {
                view.backgroundColor = .white
                UIApplication.shared.statusBarStyle = .default
            }
            else
            {
                view.backgroundColor = defaultBackgroundColor
                UIApplication.shared.statusBarStyle = .lightContent
            }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        
        defaultBackgroundColor = view.backgroundColor
        
        viewModel = MainViewModel(binder: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - TableView    
extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = viewModel.cellViewModels[indexPath.row].toString()
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        if let binder = cell as? Binder
        {
            binder.dataContext = viewModel.cellViewModels[indexPath.row].value
        }
        
        return cell
    }
}


// MARK: - 手機與手錶溝通
extension MainViewController: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Phone: \(#function), \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Phone: \(#function), \(session)")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Phone: \(#function), activationState: \(activationState), \r\nerror: \(error)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
//        guard !viewModel.isUpdate else {
//            return
//        }
        
        print("Phone: \(#function), \(message)")
        
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
