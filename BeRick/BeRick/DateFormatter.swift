//
//  DateFormatter.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 21/4/24.
//

import Foundation

extension DateFormatter {
    static func dateFormat() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }
}
