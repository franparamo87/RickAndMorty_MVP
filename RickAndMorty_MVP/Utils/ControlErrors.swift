//
//  ControlErrors.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 19/1/23.
//

import Foundation
import UIKit

protocol ControlErrorsInterface: AnyObject {
    func showAlertError(_ err: NSError)
}

class ControlErrors: ControlErrorsInterface {
    func showAlertError(_ err: NSError) {
        guard let view = UIApplication.shared.topViewController else { return }
        #if DEBUG
        let message = "Error para debug: \(err)"
        #else
        let message = err.localizedDescription
        #endif
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Aceptar", style: .default))
        view.present(alert, animated: true)
    }
}
