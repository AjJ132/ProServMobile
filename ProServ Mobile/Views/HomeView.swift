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
        VStack{
            Text("Hello World")
                .padding(2)
                .background(Color.primaryBackground)
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
