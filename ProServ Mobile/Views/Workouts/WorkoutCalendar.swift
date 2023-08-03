//
//  WorkoutCalendar.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/1/23.
//

import SwiftUI

struct WorkoutCalendar: View {
    @ObservedObject var viewModel: WorkoutCalendarViewModel
    @State private var showDetails = false
    @State private var selectedDate = Date()
    
    let calendar = Calendar.current
    
    var dates: [Date] {
        let startDate = calendar.startOfDay(for: Date())
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startDate) }
    }
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                VStack {
                    //                Button(action: {
                    //                    showDetails.toggle()
                    //                }) {
                    //                    HStack {
                    //                        Text("Some Text on the Bar")
                    //                        Spacer()
                    //                        Image(systemName: showDetails ? "chevron.up" : "chevron.down")
                    //                    }
                    //                    .padding()
                    //                    .background(Color.gray.opacity(0.2))
                    //                }
                    ZStack {
                        Color.blue
                        
                        if showDetails {
                            VStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        showDetails.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.compact.up") // Down arrow icon from SF Symbols
                                        .font(.largeTitle) // Adjust the size as needed
                                        .foregroundColor(.white) // Set the color
                                }
                            }
                            .padding(10)
                        } else {
                            VStack {
                                HStack{
                                    Image(systemName: "list.bullet.clipboard").font(.title)
                                    Text("All Workouts").font(.title)
                                    Spacer()
                                    Image(systemName: "list.bullet.clipboard").font(.title)
                                }
                                Spacer()
                                Button(action: {
                                    print("Clicked")
                                    withAnimation {
                                        showDetails.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.compact.down") // Down arrow icon from SF Symbols
                                        .font(.largeTitle) // Adjust the size as needed
                                        .foregroundColor(.white) // Set the color
                                }
                            }.padding(.horizontal, 10)
                                .padding(.bottom, 5)
                        }
                    }
                    .frame(height: showDetails ? geo.size.height * 0.3 : geo.size.height * 0.15)

                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(dates, id: \.self) { date in
                                Button(action: {
                                    selectedDate = date
                                }) {
                                    Text(viewModel.dayOfWeek(from: date)) // Create a dateFormatter to format the date as you want
                                }
                                .padding()
                            }
                        }
                    }
                    
                    VStack {
                        Text("Task 1")
                        Text("Task 2")
                        Text("Task 3")
                    }
                }
            }
        }
    }
    struct WorkoutCalendar_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutCalendar(viewModel: WorkoutCalendarViewModel())
        }
    }
    
}
