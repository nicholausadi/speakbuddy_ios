//
//  BarView.swift
//  speakbuddy-ios
//
//  Created by Nicholaus Adisetyo Purnomo on 27/12/24.
//

import SwiftUI

struct BarView: View {
    let percentage: CGFloat
    let label: String

    @State private var animatedPercentage: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()
                RoundedRectangle(cornerRadius: UIDevice.current.userInterfaceIdiom == .pad ? 8 : 4)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.barGradientStart,
                                Color.barGradientEnd,
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(
                        width: geometry.size.width,
                        height: (geometry.size.height - 40) * (animatedPercentage / 100)
                    )
                Text(label)
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 12, weight: .bold))
                    .foregroundColor(Color("primary_font"))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                animatedPercentage = percentage
            }
        }
    }
}

#Preview {
    BarView(percentage: 10, label: "Label")
}
