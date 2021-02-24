//
//  UserProfile.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import Foundation

struct UserProfile: Codable {
    
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String : Bool]
    let external_urls: [String : String]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    
    let url: String
}
