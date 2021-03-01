//
//  APICaller.swift
//  SpotifyClone
//
//  Created by Cristian Sedano Arenas on 17/02/2021.
//

import Foundation
import WebKit

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print("What's going on: \(result)")
                    completion(.success(result))
                    
                } catch {
                    print("Esto no funciona \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(complition: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    complition(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    print("No New Releases Response: \(result)")
                    complition(.success(result))
                    
                } catch {
                    complition(.failure(error))
                    print("New Release failed: \(error.localizedDescription)")
                    
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedFlaylists(completion: @escaping ((Result<FeaturePlayListResponse, Error>) -> Void)) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=2"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturePlayListResponse.self, from: data)
                    print("Success Feature Play List Response: \(result)")
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(error))
                    print("New Release failed: \(error.localizedDescription)")
                    
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
                            guard let data = data, error == nil else {
                                completion(.failure(APIError.failedToGetData))
                                return
                            }
            
                            do {
                                let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                                print("Success Get Recommendations: \(result)")
                                completion(.success(result))
            
                            } catch {
                                completion(.failure(error))
                                print("New Release failed: \(error.localizedDescription)")
            
                            }
                        }
                        task.resume()
        }
    }
    
    public func getRecommendations(genres:Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>) -> Void)) {
        
        let seeds = genres.joined(separator: ",")

        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40%seed_genres=\(seeds)"), type: .GET) { request in

            let task = URLSession.shared.dataTask(with: request) { data, _, error in

                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    print("Success Get Recommendations: \(result)")
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                    print("New Release failed: \(error.localizedDescription)")

                }
            }
            task.resume()
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
