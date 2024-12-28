//
//  PurchaseSubscriptionResponse.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Foundation
import CodableWrappers

struct PurchaseSubscriptionResponse: Decodable {
    
    /// Default `status` is enum FAILED.
    var status: PurchaseSubscriptionStatus { return PurchaseSubscriptionStatus(rawValue: _status) ?? .UNKNOWN }
    
    @FallbackDecoding<EmptyString>
    private var _status: String
    
    @FallbackDecoding<EmptyString>
    var message: String
    
    var data: SubscriptionData
    
    private enum CodingKeys: String, CodingKey {
        case _status = "status"
        case message
        case data
    }
}

enum PurchaseSubscriptionStatus: String, Decodable {
    case OK
    case FAILED
    case UNKNOWN
}
