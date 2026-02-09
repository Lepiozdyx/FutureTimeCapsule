import SwiftUI
import Charts

struct StatsView: View {
    @Binding var showCreateSheet: Bool
    @State private var storageManager = StorageManager.shared
    
    private var statistics: Statistics {
        storageManager.statistics
    }
    
    private var yearData: [(year: Int, count: Int)] {
        let yearCounts = storageManager.capsulesByYear()
        return yearCounts.sorted { $0.key < $1.key }.map { (year: $0.key, count: $0.value) }
    }
    
    private var barColors: [Color] {
        [Constants.Colors.yellow, Constants.Colors.green, Constants.Colors.blue, Constants.Colors.pink]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Constants.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Constants.Spacing.l) {
                        VStack(spacing: Constants.Spacing.m) {
                            HStack {
                                VStack(alignment: .leading, spacing: Constants.Spacing.xs) {
                                    Text("Created: \(statistics.created)")
                                        .font(Constants.Fonts.headline)
                                        .foregroundStyle(Constants.Colors.pink)
                                    
                                    Text("Opened: \(statistics.opened)")
                                        .font(Constants.Fonts.body)
                                        .foregroundStyle(.white)
                                    
                                    Text("Fulfilled: \(statistics.fulfilled)")
                                        .font(Constants.Fonts.body)
                                        .foregroundStyle(Constants.Colors.green)
                                }
                                
                                Spacer()
                                
                                Text("Success rate: \(Int(statistics.successRate))%")
                                    .font(Constants.Fonts.caption)
                                    .foregroundStyle(Constants.Colors.yellow)
                            }
                            
                            if statistics.opened > 0 {
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                            .fill(Color(hex: "2A1F3D"))
                                            .frame(height: 20)
                                        
                                        RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                            .fill(
                                                LinearGradient(
                                                    colors: [Constants.Colors.green, Constants.Colors.pink],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(width: geometry.size.width * (statistics.successRate / 100), height: 20)
                                    }
                                }
                                .frame(height: 20)
                            }
                        }
                        .padding(Constants.Spacing.m)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                .fill(Color(hex: "1B1026"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: Constants.CornerRadius.l)
                                        .stroke(Constants.Colors.blue, lineWidth: 2)
                                )
                        )
                        .padding(.horizontal, Constants.Spacing.m)
                        
                        if !yearData.isEmpty {
                            VStack(alignment: .leading, spacing: Constants.Spacing.m) {
                                Text("Statistics by years:")
                                    .font(Constants.Fonts.headline)
                                    .foregroundStyle(.white)
                                
                                HStack(alignment: .bottom, spacing: 0) {
                                    Chart(Array(yearData.enumerated()), id: \.offset) { index, data in
                                        BarMark(
                                            x: .value("Year", String(data.year)),
                                            y: .value("Count", data.count)
                                        )
                                        .foregroundStyle(barColors[index % barColors.count])
                                        .cornerRadius(8)
                                    }
                                    .chartXAxis {
                                        AxisMarks(position: .bottom) { value in
                                            AxisValueLabel {
                                                if let year = value.as(String.self) {
                                                    Text(year)
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                        }
                                    }
                                    .chartYAxis {
                                        AxisMarks(position: .leading) { value in
                                            AxisValueLabel {
                                                if let count = value.as(Int.self) {
                                                    Text("\(count)")
                                                        .font(Constants.Fonts.caption)
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 200)
                                    
                                    VStack(alignment: .leading, spacing: Constants.Spacing.xs) {
                                        ForEach(Array(yearData.enumerated().reversed()), id: \.offset) { index, data in
                                            HStack(spacing: Constants.Spacing.xs) {
                                                Circle()
                                                    .fill(barColors[index % barColors.count])
                                                    .frame(width: 8, height: 8)
                                                
                                                Text("\(data.year) - \(data.count)")
                                                    .font(Constants.Fonts.caption)
                                                    .foregroundStyle(barColors[index % barColors.count])
                                            }
                                        }
                                    }
                                    .padding(.leading, Constants.Spacing.s)
                                }
                            }
                            .padding(.horizontal, Constants.Spacing.m)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, Constants.Spacing.l)
                }
            }
            .navigationTitle("Your Stats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Constants.Colors.pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateSheet = true
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("Create")
                        }
                        .font(Constants.Fonts.headline)
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    StatsViewPreview()
}

private struct StatsViewPreview: View {
    @State private var showCreateSheet = false
    
    var body: some View {
        StatsView(showCreateSheet: $showCreateSheet)
            .onAppear {
                let mockCapsules = [
                    FutureCapsule(
                        title: "Dream 2023",
                        message: "My dream from 2023",
                        imageData: nil,
                        dreamType: .dream,
                        aboutType: .myself,
                        openDate: Calendar.current.date(byAdding: .year, value: -2, to: Date())!,
                        createdDate: Calendar.current.date(byAdding: .year, value: -3, to: Date())!,
                        openedDate: Calendar.current.date(byAdding: .year, value: -2, to: Date())!,
                        fulfillmentStatus: .fulfilled
                    ),
                    FutureCapsule(
                        title: "Goal 2024",
                        message: "My goal from 2024",
                        imageData: nil,
                        dreamType: .goal,
                        aboutType: .myself,
                        openDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                        createdDate: Calendar.current.date(byAdding: .year, value: -2, to: Date())!,
                        openedDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                        fulfillmentStatus: .fulfilled
                    ),
                    FutureCapsule(
                        title: "Love 2025",
                        message: "My love goal from 2025",
                        imageData: nil,
                        dreamType: .love,
                        aboutType: .partner,
                        openDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
                        createdDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                        openedDate: Date(),
                        fulfillmentStatus: .notFulfilled
                    ),
                    FutureCapsule(
                        title: "Future 2026",
                        message: "Sealed for future",
                        imageData: nil,
                        dreamType: .growth,
                        aboutType: .myself,
                        openDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!,
                        createdDate: Date()
                    )
                ]
                mockCapsules.forEach { StorageManager.shared.addCapsule($0) }
            }
    }
}
