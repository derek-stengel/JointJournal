//
//  CalendarDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/24/24.
//

import SwiftUI

struct CalendarDisplayView: View {
    @State private var dayColors: [String: Color] = [:]
    @State private var currentDate = Date()
    
    // State to control the color key pop-up visibility
    @State private var showColorKey = false
    
    private func getMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: currentDate)
    }
    
    private func getDaysInMonth() -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        return Array(range)
    }
    
    private func getKey(for day: Int) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let year = components.year, let month = components.month else { return "" }
        return "\(year)\(String(format: "%02d", month))\(String(format: "%02d", day))"
    }
    
    private func changeColor(for day: Int) {
        let colors: [Color] = [.red, .yellow, .green, .blue, .purple, .orange, .clear]
        let key = getKey(for: day)
        let currentColor = dayColors[key] ?? .clear
        if let nextColorIndex = colors.firstIndex(of: currentColor),
           nextColorIndex + 1 < colors.count {
            dayColors[key] = colors[nextColorIndex + 1]
        } else {
            dayColors[key] = colors[0] // Reset to the first color if we reach the end
        }
    }
    
    private func goToPreviousMonth() {
        let calendar = Calendar.current
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = previousMonth
        }
    }
    
    private func goToNextMonth() {
        let calendar = Calendar.current
        let today = Date()
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate),
           nextMonth <= today {
            currentDate = nextMonth
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: goToPreviousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                
                Text(getMonthAndYear())
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Button(action: goToNextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .padding()
                }
                .disabled(Calendar.current.isDate(currentDate, equalTo: Date(), toGranularity: .month))
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 370, height: 300)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7), spacing: 10) {
                    ForEach(getDaysInMonth(), id: \.self) { day in
                        Text("\(day)")
                            .font(.system(size: 24))
                            .bold()
                            .frame(width: 40, height: 40)
                            .background(dayColors[getKey(for: day)] ?? .clear)
                            .cornerRadius(8)
                            .onTapGesture {
                                changeColor(for: day)
                            }
                    }
                }
                .padding(10)
            }
            .padding()
            
            Button(action: {
                showColorKey.toggle() // Show the color key pop-up
            }) {
                Text("View Color Key")
                    .font(.headline)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .sheet(isPresented: $showColorKey) {
            ColorKeyPopupView()
                .presentationDetents([.height(200)]) // Restrict sheet height to 200 points
        }
    }
}

struct ColorKeyPopupView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ColorKeyView(color: .red, label: "Angry")
                ColorKeyView(color: .blue, label: "Sad / Depressed")
                ColorKeyView(color: .yellow, label: "Upset")
                ColorKeyView(color: .purple, label: "Relaxed")
                ColorKeyView(color: .green, label: "Happy")
                ColorKeyView(color: .orange, label: "Excited")
            }
            .padding()
            
            Button(action: {
                dismiss()
            }) {
                Text("Close")
                    .font(.headline)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ColorKeyView: View {
    var color: Color
    var label: String
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 20, height: 20)
                .cornerRadius(4)
            
            Text("- \(label)")
                .font(.caption)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CalendarDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDisplayView()
    }
}
