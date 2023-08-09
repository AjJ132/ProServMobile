//
//  DataState.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/27/23.
//

import Foundation


enum DataState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
}
