//
//  SubscriptionPage.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 27/12/24.
//

import SwiftUI

struct SubscriptionPage: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.pageGradientStart),
                    Color(.pageGradientEnd),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Close button
                HStack {
                    Spacer()
                    Button(
                        action: {
                            // Click button close action.
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
                }.padding(.bottom, 10)

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

                // Info text
                VStack(spacing: 0) {
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
                }

                // Subscribe button
                Button(
                    action: {
                        // TODO: Show loading and delay
                    }
                ) {
                    let buttonHeight = UIDevice.current.userInterfaceIdiom == .pad ? 80.0 : 40.0

                    Text("プランに登録する")
                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 16, weight: .semibold))
                        .foregroundColor(Color(.buttonForeground))
                        .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 600 : 400)
                        .frame(height: buttonHeight)
                        .background(Color(.buttonBackground))
                        .cornerRadius(buttonHeight / 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: buttonHeight / 2)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.20), radius: 10, x: 0, y: 2)
                }
                .padding(.vertical, 25)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SubscriptionPage()
}
