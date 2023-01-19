//
//  Error+Extension.swift
//  RickAndMorty_MVP
//
//  Created by Fran on 19/1/23.
//

import Foundation

extension NSError {
    static func create(_ message: String, code: Int = 0, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        
        let domain = (Bundle.main.bundleIdentifier ?? "com.developer") + ".error"

        let functionKey = "\(domain).function"
        let fileKey = "\(domain).file"
        let lineKey = "\(domain).line"

        let error = NSError(domain: domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: message,
            functionKey: function,
            fileKey: file,
            lineKey: line
        ])

        return error
    }
}
