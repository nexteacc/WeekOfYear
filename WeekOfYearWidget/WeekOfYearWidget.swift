// WeekCountdownWidget/WeekCountdownWidget.swift

import WidgetKit
import SwiftUI

struct WeekOfYearProvider: TimelineProvider {
    typealias Entry = WeekOfYearEntry

    func placeholder(in context: Context) -> WeekOfYearEntry {
        WeekOfYearEntry(date: Date(), remainingWeeks: "00", debugInfo: "Placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (WeekOfYearEntry) -> ()) {
        let result = WeekOfYearManager.calculateRemainingWeeks()
        let entry = WeekOfYearEntry(date: Date(), remainingWeeks: result.weeks, debugInfo: result.debug)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeekOfYearEntry>) -> ()) {
        let result = WeekOfYearManager.calculateRemainingWeeks()
        let entryDate = Date()
        let entry = WeekOfYearEntry(date: entryDate, remainingWeeks: result.weeks, debugInfo: result.debug)
        
        // 每日更新一次
        guard let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: entryDate) else {
            return
        }
        
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct WeekOfYearEntry: TimelineEntry {
    let date: Date
    let remainingWeeks: String
    let debugInfo: String
}


struct WeekOfYearWidget: Widget {
    private let kind: String = "WeekOfYearWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeekOfYearProvider()) { entry in
            WeekOfYearWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Week Countdown")
        .description("Your weeks this year")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WeekOfYearWidgetEntryView: View {
    var entry: WeekOfYearProvider.Entry
    
    private var currentYear: String {
        let year = Calendar.current.component(.year, from: Date())
        return String(year)
    }

    var body: some View {
        ZStack {
            WeekCountdownView(
                remainingWeeks: entry.remainingWeeks, 
                cardSize: 75, 
                isWidget: true, 
                showTitle: false
            )
            Text(currentYear)
                .font(.custom("SFProRounded", size: 24))
                .foregroundColor(.red)
                .offset(y: -55)
        }
        .containerBackground(.black, for: .widget)
}
}
struct WeekOfYearWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WeekOfYearWidgetEntryView(entry: WeekOfYearEntry(date: Date(), remainingWeeks: "12", debugInfo: "Preview"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
