//
//  HomeView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                
                VStack{
                    ZStack{
                        Color.blue.edgesIgnoringSafeArea(.top)
                        VStack {
                            Spacer()
                            HStack {
                                VStack(alignment: .leading){
                                    Text("Dashboard")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                }
                                
                                Spacer()
                                Image(systemName: "person.crop.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .padding([.leading, .trailing], 20)
                            .padding([.top, .bottom], 10)
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Pace Perfect")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("AJ Johnson")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .padding([.leading, .trailing], 20)
                            
                            Spacer()
                            
                            HStack{
                                    Text("Report Workout")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        
                                    
                                Spacer()
                                Button(action: {
                                    // Here is where you put the code to perform when the button is tapped.
                                    print("Button tapped!")
                                    viewModel.getUserInformation()
                                }) {
                                    Text("Report")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.orange)
                                        .cornerRadius(10)
                                }
                            }.padding([.leading, .trailing], 20)
                                .padding(.bottom, 20)
                        }
                    }.frame(height: geo.size.height * 0.4)
                    
                    
                    VStack{
                        CardView {
                            VStack(alignment: .leading){
                                Text("This Week")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    
                                Text("Workouts")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                
                                VStack(spacing: 10) {
                                    ForEach(viewModel.weekData) { data in
                                        WeekView(day: data.day, activity: data.activity, coach: data.coach)
                                    }
                                }
                            }
                        }
                        .padding(20)
                        
                        CardView{
                            VStack(alignment: .leading){
                                Text("Coaches")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    
                                Text("Pace Perfect")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                   
                                VStack(spacing: 10) {
                                    ForEach(viewModel.coachContactData) { data in
                                        CoachContactView(coachName: data.coach, coachRole: data.coachRole)
                                    }
                                }
                            }
                        }
                        .padding(20)
                    }
                }
            }.ignoresSafeArea()
            .frame(maxWidth: geo.size.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
