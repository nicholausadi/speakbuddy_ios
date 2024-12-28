//
//  SubscriptionViewModel.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 28/12/24.
//

import Alamofire
import Foundation

@MainActor
final class SubscriptionViewModel: ObservableObject {
    @Published private(set) var state = State.INITIAL_LOADING
    @Published private(set) var isPurchasing = false

    private let repository: SubscriptionRepository

    // This just sample userID for API params.
    let userID = "user123"

    init(repository: SubscriptionRepository = DefaultSubscriptionRepository()) {
        self.repository = repository

        // Call fetch subscription status at start
        Task {
            await fetchSubscriptionStatus()
        }
    }

    func fetchSubscriptionStatus() async {
        state = .INITIAL_LOADING

        do {
            let response = try await repository.getSubscriptionStatus(userID: userID)
            state = .LOADED(response.data)
        } catch {
            state = .FAILED(error)
        }
    }

    func retry() async {
        // Re-fetch subscription data
        await fetchSubscriptionStatus()
    }

    func onSubscribeButtonTapped() async {
        isPurchasing = true

        do {
            let response = try await repository.subscribe(userID: userID)
            state = .LOADED(response.data)
        } catch {
            state = .FAILED(error)
        }

        isPurchasing = false
    }

    enum State: Equatable {
        case INITIAL_LOADING
        case FAILED(Error)
        case LOADED(SubscriptionData)

        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.INITIAL_LOADING, .INITIAL_LOADING):
                return true
            case (.LOADED, .LOADED):
                return true
            case (.FAILED, .FAILED):
                return true
            default:
                return false
            }
        }
    }
}
