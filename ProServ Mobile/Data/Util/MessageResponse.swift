//
//  MessageResponse.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/13/23.
//

import Foundation


struct MessageResponse: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

