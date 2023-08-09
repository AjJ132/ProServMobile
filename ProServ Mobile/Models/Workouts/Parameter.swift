//
//  Parameter.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/7/23.
//

import Foundation

public class Parameter2: Decodable {
    var parameterId: Int
    var blockId: Int
    var sValue1: String?
    var sValue2: String?
    var tTime1: TimeInterval?
    var tTime2: TimeInterval?
    var sDistance1: Double?
    var sDistance2: Double?

    enum CodingKeys: String, CodingKey {
        case parameterId = "ParameterId"
        case blockId = "BlockId"
        case sValue1 = "SValue1"
        case sValue2 = "SValue2"
        case tTime1 = "TTime1"
        case tTime2 = "TTime2"
        case sDistance1 = "sDistance1"
        case sDistance2 = "sDistance2"
    }

    // If you need a custom initializer
    init(parameterId: Int, blockId: Int, sValue1: String?, sValue2: String?, tTime1: TimeInterval?, tTime2: TimeInterval?, sDistance1: Double?, sDistance2: Double?) {
        self.parameterId = parameterId
        self.blockId = blockId
        self.sValue1 = sValue1
        self.sValue2 = sValue2
        self.tTime1 = tTime1
        self.tTime2 = tTime2
        self.sDistance1 = sDistance1
        self.sDistance2 = sDistance2
    }
}
