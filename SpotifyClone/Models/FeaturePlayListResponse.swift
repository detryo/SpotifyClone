//
//  FeaturePlayListResponse.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 25/02/2021.
//

import Foundation

struct FeaturePlayListResponse: Codable {
    
    let playlists: PlayListResponse
}

struct PlayListResponse: Codable {
    
    let items: [PlayList]
}

struct User: Codable {
    
    let display_name: String
    let external_urls: [String : String]
    let id: String
}
