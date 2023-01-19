//
//  NavController.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
    }
    
}

extension NavController: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        item.setValuesForKeys([
            "__largeTitleTwoLineMode": true
        ])
        return true
    }
}
