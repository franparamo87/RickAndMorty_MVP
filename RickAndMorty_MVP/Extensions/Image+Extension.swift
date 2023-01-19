//
//  Image+Extension.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 18/1/23.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "placeholder")
                    }
                }
            }
        }
    }
}
