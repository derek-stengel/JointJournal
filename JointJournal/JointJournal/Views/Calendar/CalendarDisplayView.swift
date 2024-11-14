//
//  CalendarDisplayView.swift
//  JointJournal
//
//  Created by Derek Stengel on 10/24/24.
//

import SwiftUI

struct CalendarDisplayView: View {
    // Dictionary to hold colors for each day tied to month and year (e.g., 20241101 for November 1, 2024)
    @State private var dayColors: [String: Color] = [:]
    
    // Current displayed date
    @State private var currentDate = Date()
    
    // Function to get the current month and year as a string
    private func getMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: currentDate)
    }
    
    // Function to get the days in the current month
    private func getDaysInMonth() -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        return Array(range)
    }
    
    // Function to generate a unique key for each day based on month and year
    private func getKey(for day: Int) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let year = components.year, let month = components.month else { return "" }
        return "\(year)\(String(format: "%02d", month))\(String(format: "%02d", day))"
    }
    
    // Function to change the color of the selected day
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
    
    // Go to the previous month
    private func goToPreviousMonth() {
        let calendar = Calendar.current
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = previousMonth
        }
    }
    
    // Go to the next month (but limit to today’s month or earlier)
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
                // Back Arrow to navigate to the previous month
                Button(action: goToPreviousMonth) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .padding()
                }
                
                Spacer()
                
                // Month and Year Display
                Text(getMonthAndYear())
                    .font(.title)
                    .padding()
                
                Spacer()
                
                // Forward Arrow to navigate to the next month (restricted to today's month or earlier)
                Button(action: goToNextMonth) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .padding()
                }
                .disabled(Calendar.current.isDate(currentDate, equalTo: Date(), toGranularity: .month))
            }
            
            // Calendar Grid with black border around the entire calendar
            ZStack {
                // Black border around the calendar
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
                .padding(10) // numbers spacing
            }
            .padding() // border from the edge spacing
            
            // Color Key at the Bottom in Centered Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ColorKeyView(color: .red, label: "Angry")
                ColorKeyView(color: .blue, label: "Sad / Depressed")
                ColorKeyView(color: .yellow, label: "Upset")
                ColorKeyView(color: .purple, label: "Relaxed")
                ColorKeyView(color: .green, label: "Happy")
                ColorKeyView(color: .orange, label: "Excited")
                
                // create the ability to let the user edit the list of colors, and create their own.
            }
            .padding(.top)
            .padding()
            
        }
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
