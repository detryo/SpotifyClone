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
    
    struct Constants {
        static let clientID = "2dac6dfec26e45bf93ed5b930804424f"
        static let clientSecret = "78237354725345b5a5df4bf90d20403a"
    }
    
    var isSignedIn: Bool {
        false
    }
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURL = "https://www.google.com"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURL)&show_dialog=TRUE"
        
        return URL(string: string)
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
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) ->Void)) {
        
        // get token
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
