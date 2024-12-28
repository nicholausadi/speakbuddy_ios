//
//  SubscriptionRepository.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Alamofire
import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

protocol SubscriptionRepository {
    func getSubscriptionStatus(userID: String) async throws -> SubscriptionStatusResponse
    func subscribe(userID: String) async throws -> PurchaseSubscriptionResponse
}

final class DefaultSubscriptionRepository: SubscriptionRepository {
    init() {
        // Only for demo purpose.
        setupStubs()
    }

    func getSubscriptionStatus(userID: String) async throws -> SubscriptionStatusResponse {
        let params = SubscriptionStatusParams(userID: userID)

        do {
            let response = try await AF.request(
                Endpoints.subscriptionStatus.url,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .serializingDecodable(SubscriptionStatusResponse.self)
            .value

            return response
        } catch {
            // Log the specific decoding error
            print("Decoding error: \(error)")
            throw error
        }
    }

    func subscribe(userID: String) async throws -> PurchaseSubscriptionResponse {
        let params = PurchaseSubscriptionParams(userID: userID)

        do {
            let response = try await AF.request(
                Endpoints.purchaseSubscription.url,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .serializingDecodable(PurchaseSubscriptionResponse.self)
            .value

            return response
        } catch {
            // Log the specific decoding error
            print("Decoding error: \(error)")
            throw error
        }
    }

    // Setup stubs for demo purpopse.
    // Delay response 0.5 second.
    private func setupStubs() {
        stub(condition: isPath("/subscription/status")) { _ in
            let stubPath = OHPathForFile("get_subscription_status_response.json", DefaultSubscriptionRepository.self)
            return fixture(
                filePath: stubPath!,
                headers: ["Content-Type": "application/json"]
            ).responseTime(0.5)
        }

        stub(condition: isPath("/subscription/purchase")) { _ in
            let stubPath = OHPathForFile("purchase_subscription_response.json", DefaultSubscriptionRepository.self)
            return fixture(
                filePath: stubPath!,
                headers: ["Content-Type": "application/json"]
            ).responseTime(0.5)
        }
    }
}
