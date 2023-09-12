//
//  NetworkingImageHandle.swift
//  MovieFlix
//
//  Created by Doni on 18/02/23.
//

import UIKit

class NetworkingImageHandle {
    
    enum Constants {
        static let w500ImageUrl = "https://image.tmdb.org/t/p/w500"
        static let w200ImageUrl = "https://image.tmdb.org/t/p/w200"
    }
    
    static let shared = NetworkingImageHandle()
    public let cache = NSCache<NSString, UIImage>()
    
    public func downloadPosterDetailImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: Constants.w500ImageUrl + urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    public func downloadPosterCellImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: Constants.w200ImageUrl + urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    public func downloadBackdropCellImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: Constants.w500ImageUrl + urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
