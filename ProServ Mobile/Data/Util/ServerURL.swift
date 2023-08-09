//
//  ServerURL.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/8/23.
//

import Foundation

struct ServerURL {
    static let development = "http://localhost:5274"
    static let production = "https://proserv.azurewebsites.net"
    
    #if DEBUG
    static let baseURL = ServerURL.development
    #else
    static let baseURL = ServerURL.production
    #endif
}
