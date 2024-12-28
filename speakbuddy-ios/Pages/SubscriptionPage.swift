//
//  SubscriptionPage.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 27/12/24.
//

import SwiftUI

struct SubscriptionPage: View {
    @StateObject private var viewModel = SubscriptionViewModel()

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [.pageGradientStart, .pageGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            switch viewModel.state {
            case .INITIAL_LOADING:
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 200, height: 200)
                        .overlay {
                            VStack(alignment: .center) {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                    .scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1.5)

                                Text("Fetching subscription data")
                                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 14))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 24)
                            }.padding(20)
                        }
                }

            case let .LOADED(data):
                VStack(spacing: 0) {
                    // Close button
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                // Dismiss the view
                            }
                        ) {
                            let buttonSize: Double = UIDevice.current.userInterfaceIdiom == .pad ? 60 : 38

                            Image(systemName: "xmark")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16))
                                .foregroundColor(Color(.primaryFont))
                                .frame(width: buttonSize, height: buttonSize)
                                .background(Circle().fill(Color.white))
                                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 2)
                        }
                    }.padding(.vertical, 10)

                    // Title
                    Text("Hello\nSpeakBUDDY")
                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 36))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("primary_font"))

                    // Bars View with animation
                    HStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 48 : 26) {
                        BarView(percentage: 20, label: "現在")
                        BarView(percentage: 40, label: "3ヶ月")
                        BarView(percentage: 80, label: "1年")
                        BarView(percentage: 100, label: "2年")
                    }
                    .padding(.top, 80)
                    .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 100 : 40)
                    .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 200 : 40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        Image(.protty)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 180)
                            .position(
                                CGPoint(
                                    x: UIScreen.main.bounds.width * 0.25,
                                    y: UIScreen.main.bounds.height * 0.15
                                )
                            )
                    )

                    switch data.status {
                    case .NOT_SUBSCRIBED:
                        VStack(spacing: 0) {
                            // Info text
                            Text("スピークバディで")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20, weight: .semibold))
                                .foregroundColor(Color("primary_font"))
                                .multilineTextAlignment(.center)
                            Text("レベルアップ")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 52 : 30, weight: .semibold))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(.fontGradientStart),
                                            Color(.fontGradientEnd),
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )

                            // Subscribe button
                            Button {
                                Task {
                                    await viewModel.onSubscribeButtonTapped()
                                }
                            } label: {
                                let buttonHeight = UIDevice.current.userInterfaceIdiom == .pad ? 80.0 : 40.0
                                let spinnerScale = UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.0

                                ZStack {
                                    Text("プランに登録する")
                                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 16, weight: .semibold))
                                        .foregroundColor(Color(.buttonForeground))
                                        .opacity(viewModel.isPurchasing ? 0 : 1)

                                    if viewModel.isPurchasing {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.buttonForeground)))
                                            .scaleEffect(spinnerScale)
                                    }
                                }
                                .frame(maxWidth: viewModel.isPurchasing ? buttonHeight : (UIDevice.current.userInterfaceIdiom == .pad ? 600 : 400))
                                .frame(height: buttonHeight)
                                .background(viewModel.isPurchasing ? Color.gray.opacity(0.5) : Color(.buttonBackground))
                                .cornerRadius(buttonHeight / 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: buttonHeight / 2)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: .black.opacity(0.20), radius: 10, x: 0, y: 2)
                                .animation(.spring(duration: 0.3), value: viewModel.isPurchasing)
                            }
                            .disabled(viewModel.isPurchasing)
                            .padding(.vertical, 25)
                        }.frame(minHeight: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 200)

                    case .SUBSCRIBED:
                        // Congratulations section
                        VStack(spacing: 16) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 60))
                                .foregroundColor(.green)

                            Text("Subscribed! 🎉")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 24, weight: .bold))
                                .foregroundColor(Color("primary_font"))

                            Text("You are using SpeakBUDDY's features")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }.frame(minHeight: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 200)

                    case .SUBSCRIBED_EXPIRED:
                        // Expired info text
                        VStack(spacing: 0) {
                            Text("Subscription Expired")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20, weight: .semibold))
                                .foregroundColor(Color("primary_font"))
                                .multilineTextAlignment(.center)
                            Text("Renew subscription to continue learning")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 52 : 30, weight: .semibold))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(.fontGradientStart),
                                            Color(.fontGradientEnd),
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )

                            // Subscribe button
                            Button {
                                Task {
                                    await viewModel.onSubscribeButtonTapped()
                                }
                            } label: {
                                let buttonHeight = UIDevice.current.userInterfaceIdiom == .pad ? 80.0 : 40.0
                                let spinnerScale = UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.0

                                ZStack {
                                    Text("プランに登録する")
                                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 16, weight: .semibold))
                                        .foregroundColor(Color(.buttonForeground))
                                        .opacity(viewModel.isPurchasing ? 0 : 1)

                                    if viewModel.isPurchasing {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.buttonForeground)))
                                            .scaleEffect(spinnerScale)
                                    }
                                }
                                .frame(maxWidth: viewModel.isPurchasing ? buttonHeight : (UIDevice.current.userInterfaceIdiom == .pad ? 600 : 400))
                                .frame(height: buttonHeight)
                                .background(viewModel.isPurchasing ? Color.gray.opacity(0.5) : Color(.buttonBackground))
                                .cornerRadius(buttonHeight / 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: buttonHeight / 2)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: .black.opacity(0.20), radius: 10, x: 0, y: 2)
                                .animation(.spring(duration: 0.3), value: viewModel.isPurchasing)
                            }
                            .disabled(viewModel.isPurchasing)
                            .padding(.vertical, 25)
                        }.frame(minHeight: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 200)

                    case .UNKNOWN:
                        // Handle unknown status
                        VStack(spacing: 0) {
                            Text("Can't get subscription information")
                                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20, weight: .semibold))
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }.frame(minHeight: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 200)
                    }
                }
                .padding(.horizontal, 20)

            case let .FAILED(error):
                // Error handling view
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .overlay {
                            VStack(spacing: 20) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40))
                                    .foregroundColor(.red)
                                    .padding(.top)

                                Text("Error Occurred")
                                    .font(.headline)
                                    .fontWeight(.bold)

                                Text(error.localizedDescription)
                                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 14))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)

                                Button(action: {
                                    Task {
                                        await viewModel.retry()
                                    }
                                }) {
                                    Text("Retry")
                                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 200 : 150, height: UIDevice.current.userInterfaceIdiom == .pad ? 50 : 40)
                                        .background(Color(.buttonBackground))
                                        .cornerRadius(25)
                                }
                                .padding(.bottom)
                            }
                        }
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

#Preview {
    SubscriptionPage()
}
