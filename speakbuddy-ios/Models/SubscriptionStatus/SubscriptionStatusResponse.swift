//
//  SubscriptionStatusResponse.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Foundation
import CodableWrappers

struct SubscriptionStatusResponse: Decodable {
    
    /// Default `status` is enum UNKNOWN.
    var status: SubscriptionResponseStatus { return SubscriptionResponseStatus(rawValue: _status) ?? .UNKNOWN }
    
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

enum SubscriptionResponseStatus: String, Decodable {
    case OK
    case FAILED
    case UNKNOWN
}
