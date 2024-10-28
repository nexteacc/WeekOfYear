//
//  WeekOfYearApp.swift
//  WeekOfYear
//
//  Created by Sheng on 10/24/24.
//

import SwiftUI

@main
struct WeekOfYearApp: App {
    init() {
        MetricsManager.shared.startCollecting()
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.ignoresSafeArea()
                WeekCountdownView(cardSize: 150, isWidget: false)
            }
            .environment(\.locale, .current)
        }
    }
}

