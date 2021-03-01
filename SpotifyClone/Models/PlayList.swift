//
//  PlayList.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import Foundation

struct PlayList: Codable {
    
    let description: String
    let external_urls: [String : String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
