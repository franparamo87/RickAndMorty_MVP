//
//  BaseView.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 19/1/23.
//

import UIKit
import iProgressHUD

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemGroupedBackground
        if let nav = navigationController, nav.viewControllers.count > 1 {
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationItem.setLeftBarButton(.init(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back)), animated: true)
        }
        
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.dismissProgress()
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
