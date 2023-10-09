//
//  String+Extensions.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import Foundation

extension String {
    
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
    
}
