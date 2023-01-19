//
//  Control+Extension.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 19/1/23.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
