//
//  Artist.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import Foundation

struct Artist: Codable {
    
    let id: String
    let name: String
    let type: String
    let external_urls: [String : String]
}
