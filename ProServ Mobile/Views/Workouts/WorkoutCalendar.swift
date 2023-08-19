//
//  WorkoutCalendar.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 8/1/23.
//
import Combine
import SwiftUI
import SwiftUISnappingScrollView

struct WorkoutCalendar: View {
    @Environment(\.colorScheme) var colorScheme // Detect the current color scheme
    @ObservedObject var viewModel: WorkoutCalendarViewModel
    @State private var showDetails = false
    @State private var viewOption = "Today"
    @State private var isCollapsed = false
    
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
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.dates, id: \.self) { date in
                                        Button(action: {
                                            //viewModel.selectedDate = date
                                            viewModel.selectDate(newDate: date)
                                        }) {
                                            Text(viewModel.dayOfWeek(from: date))
                                                .foregroundColor(viewModel.selectedDate == date ? .white : Color(.opaqueSeparator))
                                                .font(viewModel.selectedDate == date ? .title2 : .title3)
                                        }
                                        .padding()
                                        .id(date) // Assign an ID to each item
                                    }
                                }
                                .onAppear {
                                    proxy.scrollTo(viewModel.selectedDate, anchor: .leading) // Change anchor as needed
                                }
                                
                            }
                        }
                        
                        
                    }.padding(.horizontal)
                   
                    ZStack {
                        Color(.systemBackground)
                        if viewModel.hasWorkoutToday == false{
                            VStack{
                                Spacer()
                                Text("No Workout Today")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .padding(.top, 20)
                                
                                Spacer()
                                Spacer()
                            }.padding()
                        } else {
                            ScrollView{
                                VStack {
                                    
                                        VStack {
                                            //Name
                                            HStack{
                                                Text("Name")
                                                    .foregroundColor(.placeholderText)
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                Spacer()
                                            }
                                            HStack{
                                                Text(viewModel.selectedWorkout?.workoutName ?? "N/A")
                                                    .foregroundColor(.primary)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                Spacer()
                                            }
                                            
                                            //Coach
                                            HStack{
                                                Text("Coach")
                                                    .foregroundColor(.placeholderText)
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                Spacer()
                                            }.padding(.top)
                                            HStack{
                                                Text(viewModel.selectedWorkout?.coachName ?? "COACH")
                                                    .foregroundColor(.primary)
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                Spacer()
                                            }
                                            Spacer()
                                            
                                            //Info
                                            HStack{
                                                Spacer()
                                                VStack{
                                                    Text("2")
                                                        .foregroundColor(.primary)
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                    Text("Exercises")
                                                        .foregroundColor(.placeholderText)
                                                        .font(.caption)
                                                        .fontWeight(.medium)
                                                }
                                                Spacer()
                                                VStack{
                                                    Text("????")
                                                        .foregroundColor(.primary)
                                                        .font(.subheadline)
                                                        .fontWeight(.semibold)
                                                    Text("Duration")
                                                        .foregroundColor(.placeholderText)
                                                        .font(.caption)
                                                        .fontWeight(.medium)
                                                }
                                                Spacer()
                                            }.padding(.top)
                                        }
                                        .padding()  // Padding inside the RoundedRectangle.
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(.tertiarySystemBackground))
                                                .shadow(color: Color(.placeholderText), radius: 5)
                                        )
                                        
                                        HStack{
                                            Text("Exercises")
                                                .foregroundColor(.placeholderText)
                                                .font(.caption)
                                                .fontWeight(.medium)
                                            Spacer()
                                        }.padding(.top)
                                        
                                        ForEach(viewModel.selectedWorkout!.workoutBlocks.blocks, id: \.id){ block in
                                            VStack{
                                                HStack{
                                                    ZStack{
                                                        Circle()
                                                            .fill(Color.blue)
                                                            .frame(width: 40, height: 40) // Adjust the size of the circle
                                                        Text("\(block.blockOrder + 1)")
                                                            .foregroundColor(.white)
                                                            .font(.title3)
                                                            .fontWeight(.semibold)
                                                        
                                                    }.padding(.trailing, 5)
                                                    VStack {
                                                        HStack{
                                                            Text(block.blockName)
                                                                .fontWeight(.semibold)
                                                            Spacer()
                                                        }
                                                        
                                                        if isCollapsed {
                                                            HStack {
                                                                Text("...")
                                                                    .foregroundColor(.secondaryLabel)
                                                                Spacer() // This pushes the text to the left
                                                            }
                                                        } else {
                                                            Spacer()
                                                        }
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    //Collapse Button
                                                    Button(action: toggleCollapse) {
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color.blue)
                                                                .frame(width: 25, height: 25) // Adjust the size of the circle
                                                            
                                                            Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                                                                .foregroundColor(Color.darkText) // Set the color explicitly
                                                            
                                                        }
                                                    }
                                                }
                                                if !isCollapsed {
                                                    HStack{
                                                        ZStack{
                                                            Circle()
                                                                .fill(Color.systemGray3)
                                                                .frame(width: 20, height: 20) // Adjust the size of the circle
//                                                            Text("\(block.blockOrder + 1)")
//                                                                .foregroundColor(.white)
//                                                                .font(.headline)
//                                                                 .fontWeight(.semibold)
                                                        }.padding(.leading, 10)
                                                            .padding(.trailing, 15)
                                                        
                                                        switch block.blockType {
                                                            case "Long Run":
                                                            let test = block
                                                            let test2 = block.parameters
//                                                            print("Pace: " + pace)
//                                                                Text("Pace: \(pace)")
//                                                                .font(.headline)
                                                            default:
                                                                Text("N/A")
                                                                    .font(.headline)
                                                        }
                                                        
                                                        
//                                                        Text("2 Mile Run")
//                                                            .font(.headline)
                                                        Spacer()
                                                        
                                                    }
                                                    
                                                    HStack{
                                                        ZStack{
                                                            Circle()
                                                                .fill(Color.systemGray3)
                                                                .frame(width: 20, height: 20) // Adjust the size of the circle
                                                            Text("2")
                                                                .foregroundColor(.white)
                                                                .font(.headline)
                                                                .fontWeight(.semibold)
                                                        }.padding(.leading, 10)
                                                            .padding(.trailing, 15)
                                                        
                                                        Text("Dynamic Strech")
                                                            .font(.headline)
                                                        
                                                        Spacer()
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        
                                        
                                        //MARK: - Section Old Code
//                                        VStack {
//                                            
//                                            VStack{
//                                                HStack{
//                                                    ZStack{
//                                                        Circle()
//                                                            .fill(Color.blue)
//                                                            .frame(width: 40, height: 40) // Adjust the size of the circle
//                                                        Text("A")
//                                                            .foregroundColor(.white)
//                                                            .font(.title3)
//                                                            .fontWeight(.semibold)
//                                                        
//                                                    }.padding(.trailing, 5)
//                                                    VStack {
//                                                        HStack{
//                                                            Text("Warmup")
//                                                                .fontWeight(.semibold)
//                                                            Spacer()
//                                                        }
//                                                        
//                                                        if isCollapsed {
//                                                            HStack {
//                                                                Text("...")
//                                                                    .foregroundColor(.secondaryLabel)
//                                                                Spacer() // This pushes the text to the left
//                                                            }
//                                                        } else {
//                                                            Spacer()
//                                                        }
//                                                    }
//                                                    
//                                                    Spacer()
//                                                    
//                                                    //Collapse Button
//                                                    Button(action: toggleCollapse) {
//                                                        ZStack {
//                                                            Circle()
//                                                                .fill(Color.blue)
//                                                                .frame(width: 25, height: 25) // Adjust the size of the circle
//                                                            
//                                                            Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
//                                                                .foregroundColor(Color.darkText) // Set the color explicitly
//                                                            
//                                                        }
//                                                    }
//                                                    
//                                                    
//                                                }
//                                                if !isCollapsed {
//                                                    HStack{
//                                                        ZStack{
//                                                            Circle()
//                                                                .fill(Color.systemGray3)
//                                                                .frame(width: 20, height: 20) // Adjust the size of the circle
//                                                            Text("1")
//                                                                .foregroundColor(.white)
//                                                                .font(.headline)
//                                                                .fontWeight(.semibold)
//                                                        }.padding(.leading, 10)
//                                                            .padding(.trailing, 15)
//                                                        
//                                                        Text("2 Mile Run")
//                                                            .font(.headline)
//                                                        
//                                                        Spacer()
//                                                        
//                                                    }
//                                                    
//                                                    HStack{
//                                                        ZStack{
//                                                            Circle()
//                                                                .fill(Color.systemGray3)
//                                                                .frame(width: 20, height: 20) // Adjust the size of the circle
//                                                            Text("2")
//                                                                .foregroundColor(.white)
//                                                                .font(.headline)
//                                                                .fontWeight(.semibold)
//                                                        }.padding(.leading, 10)
//                                                            .padding(.trailing, 15)
//                                                        
//                                                        Text("Dynamic Strech")
//                                                            .font(.headline)
//                                                        
//                                                        Spacer()
//                                                        
//                                                    }
//                                                }
//                                            }
//                                            
//                                            Divider()
//                                            
//                                            VStack{
//                                                HStack{
//                                                    ZStack{
//                                                        Circle()
//                                                            .fill(Color.blue)
//                                                            .frame(width: 40, height: 40) // Adjust the size of the circle
//                                                        Text("B")
//                                                            .foregroundColor(.white)
//                                                            .font(.title3)
//                                                            .fontWeight(.semibold)
//                                                    }
//                                                    VStack{
//                                                        Text("Long Run")
//                                                            .fontWeight(.semibold)
//                                                        Spacer()
//                                                    }
//                                                    Spacer()
//                                                    ZStack{
//                                                        Circle()
//                                                            .fill(Color.blue)
//                                                            .frame(width: 25, height: 25) // Adjust the size of the circle
//                                                        Image(systemName: "chevron.up")
//                                                        
//                                                    }
//                                                    
//                                                }
//                                                
//                                                HStack{
//                                                    ZStack{
//                                                        Circle()
//                                                            .fill(Color.systemGray3)
//                                                            .frame(width: 20, height: 20) // Adjust the size of the circle
//                                                        Text("1")
//                                                            .foregroundColor(.white)
//                                                            .font(.headline)
//                                                            .fontWeight(.semibold)
//                                                    }.padding(.leading, 10)
//                                                        .padding(.trailing, 15)
//                                                    
//                                                    Text("6 Mile Run")
//                                                        .font(.headline)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("8:30/mi")
//                                                    
//                                                }
//                                                
//                                                HStack{
//                                                    ZStack{
//                                                        Circle()
//                                                            .fill(Color.systemGray3)
//                                                            .frame(width: 20, height: 20) // Adjust the size of the circle
//                                                        Text("2")
//                                                            .foregroundColor(.white)
//                                                            .font(.headline)
//                                                            .fontWeight(.semibold)
//                                                    }.padding(.leading, 10)
//                                                        .padding(.trailing, 15)
//                                                    
//                                                    Text("1 Mile Cooldown")
//                                                        .font(.headline)
//                                                    
//                                                    Spacer()
//                                                    
//                                                }
//                                            }
//                                        }
//                                        .padding(20)  // Padding inside the RoundedRectangle.
//                                        .background(
//                                            RoundedRectangle(cornerRadius: 12)
//                                                .fill(Color(.tertiarySystemBackground))
//                                                .shadow(color: Color(.placeholderText), radius: 5)
//                                        )
                                        
                                    
                                    
                                }
                                .padding(30)
                            }
                        }
                        
                        
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
    
    func toggleCollapse() {
        withAnimation { // Animate the collapse/expand
            isCollapsed.toggle() // Toggle the state
        }
    }
}



struct WorkoutCalendar_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCalendar(viewModel: WorkoutCalendarViewModel())
    }
}




