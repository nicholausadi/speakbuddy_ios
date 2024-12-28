//
//  SubscriptionData.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Foundation
import CodableWrappers

struct SubscriptionData: Decodable {
    
    /// Default `status` is enum UNKNOWN.
    var status: SubscriptionStatus { return SubscriptionStatus(rawValue: _status) ?? .UNKNOWN }
    
    @FallbackDecoding<EmptyString>
    private var _status: String
    
    @FallbackDecoding<EmptyDouble>
    var priceMonthly: Double
    
    @FallbackDecoding<EmptyDouble>
    var priceYearly: Double
    
    @FallbackDecoding<EmptyString>
    var currency: String
    
    private enum CodingKeys: String, CodingKey {
        case _status = "status"
        case priceMonthly = "price_monthly"
        case priceYearly = "price_yearly"
        case currency
    }
}

enum SubscriptionStatus: String, Decodable {
    case SUBSCRIBED
    case NOT_SUBSCRIBED
    case SUBSCRIBED_EXPIRED
    case UNKNOWN
}
