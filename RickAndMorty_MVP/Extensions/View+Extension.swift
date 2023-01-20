//
//  View+Extension.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 20/1/23.
//

import UIKit

extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }

    func addCloseButton() {
        let button = UIBarButtonItem(image: .init(systemName: "xmark"),
                                 style: .done,
                                 target: self,
                                 action: #selector(onClose))
        navigationItem.rightBarButtonItem = button
    }

    @objc func onClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
