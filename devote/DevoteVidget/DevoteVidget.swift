//
//  DevoteVidget.swift
//  DevoteVidget
//
//  Created by Thomas Mani on 26/09/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteVidgetEntryView : View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var fontStyle:Font{
        if widgetFamily == .systemSmall{
            return .system(.footnote,design: .rounded)
        } else {
            return .system(.headline,design: .rounded)
        }
    }
    
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.date, style: .time)
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(width: widgetFamily != .systemSmall ? 56 : 36, height: widgetFamily != .systemSmall ? 56 : 36)
                    .offset(x: (geometry.size.width / 2) - 20, y: (geometry.size.height / -2) + 20)
                    .padding(.top,widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing,widgetFamily != .systemSmall ? 32 :12)
                
                HStack {
                    Text("Just Do It")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal,12)
                        .padding(.vertical,4)
                        .background(Color.black.opacity(0.5).blendMode(.overlay))
                    .clipShape(Capsule())
                    
                    if widgetFamily != .systemSmall{
                        Spacer()
                    }
                    
                }
                .padding()
                .offset(x: 0, y: (geometry.size.height / 2) - 24)
            }
        }
    }
}

struct DevoteVidget: Widget {
    let kind: String = "DevoteVidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteVidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote launcher")
        .description("This is an example widget for personal task manager app.")
    }
}

struct DevoteVidget_Previews: PreviewProvider {
    static var previews: some View {
        DevoteVidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        DevoteVidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        DevoteVidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        DevoteVidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
