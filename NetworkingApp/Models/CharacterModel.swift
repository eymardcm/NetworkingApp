//
//  CharacterModel.swift
//  NetworkingApp
//
//  Created by Chad Eymard on 4/14/24.
//

import Foundation

struct Character: Codable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
