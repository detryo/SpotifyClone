//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToke: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
