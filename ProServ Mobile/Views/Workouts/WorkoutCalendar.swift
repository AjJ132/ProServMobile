//
//  WorkoutCalendar.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/1/23.
//

import SwiftUI

struct WorkoutCalendar: View {
    @Environment(\.colorScheme) var colorScheme // Detect the current color scheme
    @ObservedObject var viewModel: WorkoutCalendarViewModel
    @State private var showDetails = false
    @State private var selectedDate = Date()
    @State private var viewOption = "Today"
    
    let calendar = Calendar.current
    
    var dates: [Date] {
        let startDate = calendar.startOfDay(for: Date())
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startDate) }
    }
    
    var body: some View {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        VStack{
                            HStack{
                                Image(systemName: "list.bullet.clipboard")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                Text("Workouts")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                Spacer()
                            }
                            HStack{
                                Text(viewOption)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                                HStack{
                                    Button(action:{
                                        viewModel.previousWeek()
                                    }){
                                        Image(systemName: "arrow.left.square.fill")
                                            .font(.title3)
                                            .foregroundColor(.white)
                                    }
                                    Text(viewModel.weekStart)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Text("-")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Text(viewModel.weekEnd)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    Button(action:{
                                        viewModel.nextWeek()
                                    }){
                                        Image(systemName: "arrow.right.square.fill")
                                            .font(.title3)
                                            .foregroundColor(.white)
                                    }
                                }
                            }.padding((.top))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(dates, id: \.self) { date in
                                        Button(action: {
                                            selectedDate = date
                                        }) {
                                            Text(viewModel.dayOfWeek(from: date)).foregroundColor(.white)
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }.padding(.horizontal)
                        ZStack {
                            Color(.systemBackground)
                            
                            VStack {
                                
                            }
                            .padding()
                        }
                        .frame(height: geo.size.height)
                        .offset(y: showDetails ? (geo.size.height * 0.3 - 90) : geo.size.height * 0.1 - 90) // Change the offset based on condition
                        .padding(.top, 20)
                    }
                }
                .animation(.easeInOut(duration: 0.3)) // Apply animation outside ScrollView
                .frame(height: geo.size.height)
            }.background(Color.blue)
        }
    }

    struct WorkoutCalendar_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutCalendar(viewModel: WorkoutCalendarViewModel())
        }
    }
    

