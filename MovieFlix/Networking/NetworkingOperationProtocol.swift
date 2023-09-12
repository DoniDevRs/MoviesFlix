//
//  NetworkingOperationProtocol.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation

protocol NetworkingOperationProtocol: AnyObject {
    func execute<T: Codable>(request: RequestProtocol, responseType: T.Type, completion: @escaping (Result<T, MFError>) -> Void)
}
