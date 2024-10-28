//
//  WeekCountdownView.swift
//  WeekOfYear
//
//  Created by Sheng on 10/24/24.
//


import SwiftUI

public struct WeekCountdownView: View {
    let remainingWeeks: String?
    @State private var internalRemainingWeeks: String = "00"
    @State private var debugInfo: String = ""

    let cardSize: CGFloat
    let isWidget: Bool
    let showTitle: Bool

    public init(remainingWeeks: String? = nil, cardSize: CGFloat = 20, isWidget: Bool = false, showTitle: Bool = true ) {
        self.remainingWeeks = remainingWeeks
        self.cardSize = cardSize
        self.isWidget = isWidget
        self.showTitle = showTitle
    }

    public var body: some View {
        VStack {
            if showTitle {
                Text("A Week is 2% of a Year")
                    .font(.custom("SFProRounded", size: isWidget ? 16 : 24))
                    .foregroundColor(.white)
                    .padding(.bottom, isWidget ? 10 : 20)
            }
            HStack(spacing: isWidget ? 6 : 4) {
                ForEach(Array(remainingWeeks ?? internalRemainingWeeks), id: \.self) { digit in
                    FlipCard(
                        digit: String(digit),
                        size: cardSize
                    )
                }
            }
        }
        .padding(isWidget ? 8 : 20)
        .cornerRadius(isWidget ? 0 : 16)
        .onAppear {
            if remainingWeeks == nil {
                let result = WeekOfYearManager.calculateRemainingWeeks()
                internalRemainingWeeks = result.weeks
                debugInfo = result.debug
            }
        }
    }
}

public struct FlipCard: View {
    let digit: String
    let size: CGFloat

    public init(digit: String, size: CGFloat) {
        self.digit = digit
        self.size = size
    }

    public var body: some View {
        VStack(spacing: 1) {
            DigitHalf(digit: digit, size: size)
        }
        .background(Color(white: 0.1))
        .cornerRadius(8)
    }
}

public struct DigitHalf: View {
    let digit: String
    let size: CGFloat

    public init(digit: String, size: CGFloat) {
        self.digit = digit
        self.size = size
    }

    public var body: some View {
        Text(digit)
             .font(.custom("SFProRounded", size: size * 0.9))
            .foregroundColor(.white)
            .frame(width: size, height: size)
            .contentShape(Rectangle())
    }
}

struct WeekCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCountdownView(remainingWeeks: "12", cardSize: 20, isWidget: true)
            .previewLayout(.fixed(width: 100, height: 100))
            .background(Color.white)
        WeekCountdownView(remainingWeeks: "12", cardSize: 40, isWidget: false)
            .previewLayout(.fixed(width: 200, height: 200))
            .background(Color.black)
    }
}
