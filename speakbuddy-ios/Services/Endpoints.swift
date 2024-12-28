//
//  Endpoints.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Foundation
import Alamofire

struct BaseUrl {
    static let url = "https://api.speakbuddy.com"
}

enum Endpoints {
    case subscriptionStatus
    case purchaseSubscription
    
    public var url: String {
        switch self {
        case .subscriptionStatus: return "\(BaseUrl.url)/subscription/status"
        case .purchaseSubscription: return "\(BaseUrl.url)/subscription/purchase"
        }
    }
}
