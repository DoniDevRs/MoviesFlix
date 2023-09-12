//
//  RequestProtocol.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    var baseURL: String { get }
    var path: String {get }
    var method: HTTPMethod {get }
}
