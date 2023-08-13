//
//  HomeView.swift
//  ProServ Mobile
//
//  Created by AJ Johnson on 7/10/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isCollapsed = false
    @Binding var selectedTab: Int
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
                                Button(action:{
                                    selectedTab = 2
                                }){
                                    Image(systemName: "person.crop.circle")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding([.leading, .trailing], 20)
                            .padding([.top, .bottom], 10)
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Text(viewModel.userTeamName)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text(viewModel.userFirstName)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                }
                                Spacer()
                            }
                            .padding([.leading, .trailing], 20)
                            
                            Spacer()
                            
                        }.padding(.top, 20)
                    }.frame(height: geo.size.height * 0.25)
                    
                    
                    VStack{
//                        HStack{
//                            Text("Today")
//                                .foregroundColor(.placeholderText)
//                                .font(.caption)
//                                .fontWeight(.medium)
//                            Spacer()
//                        }.padding(.top)
                        VStack {
                            
                            VStack{
                                HStack{
                                    Text("Today")
                                        .foregroundColor(.placeholderText)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                HStack{
                                    Text("Long Run")
                                        .foregroundColor(.primary)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 40, height: 40) // Adjust the size of the circle
                                        Text("A")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        
                                    }.padding(.trailing, 5)
                                    VStack {
                                        HStack{
                                            Text("Warmup")
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
                                            Text("1")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                        }.padding(.leading, 10)
                                            .padding(.trailing, 15)
                                        
                                        Text("2 Mile Run")
                                            .font(.headline)
                                        
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
                            
                            Divider()
                            
                            VStack{
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 40, height: 40) // Adjust the size of the circle
                                        Text("B")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                    VStack{
                                        Text("Long Run")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    Spacer()
                                    ZStack{
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 25, height: 25) // Adjust the size of the circle
                                        Image(systemName: "chevron.up")
                                        
                                    }
                                    
                                }
                                
                                HStack{
                                    ZStack{
                                        Circle()
                                            .fill(Color.systemGray3)
                                            .frame(width: 20, height: 20) // Adjust the size of the circle
                                        Text("1")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }.padding(.leading, 10)
                                        .padding(.trailing, 15)
                                    
                                    Text("6 Mile Run")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text("8:30/mi")
                                    
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
                                    
                                    Text("1 Mile Cooldown")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                }
                            }
                        }
                        .padding(20)  // Padding inside the RoundedRectangle.
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.tertiarySystemBackground))
                                .shadow(color: Color(.placeholderText), radius: 5)
                        )
                        
                        
                        
                        HStack{
                            Text("Coaches")
                                .foregroundColor(.placeholderText)
                                .font(.caption)
                                .fontWeight(.medium)
                            Spacer()
                        }.padding(.top)
                        
                        VStack{
                            
                            
                            VStack(alignment: .leading){
                                
                                
                                Text("Pace Perfect")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                
                                VStack(spacing: 10) {
                                    ForEach(viewModel.coachContactData) { data in
                                        HStack{
                                            VStack(alignment: .leading){
                                                Text(data.coach)
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                Text(data.coachRole)
                                                    .font(.subheadline)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.systemGray2)
                                            }
                                            Spacer()
                                            Button(action: {
                                                            // Here is where you put the code to perform when the button is tapped.
                                                            print("Button tapped!")
                                                        }) {
                                                            Text("Contact")
                                                                .font(.caption)
                                                                .foregroundColor(.white)
                                                                .padding()
                                                                .background(Color.orange)
                                                                .cornerRadius(10)
                                                        }
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.tertiarySystemBackground))
                                .shadow(color: Color(.placeholderText), radius: 5)
                        )
                        
                    }.padding()
                    
                    
                }
            }.ignoresSafeArea()
                .frame(maxWidth: geo.size.width)
        }
    }
    
    func toggleCollapse() {
        withAnimation { // Animate the collapse/expand
            isCollapsed.toggle() // Toggle the state
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(), selectedTab: .constant(0))
    }
}
