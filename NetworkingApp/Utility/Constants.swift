//
//  Constants.swift
//  NetworkingApp
//
//  Created by Chad Eymard on 4/14/24.
//

import Foundation

extension String {
    var replaceStringWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
