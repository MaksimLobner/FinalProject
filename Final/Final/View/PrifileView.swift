//
//  PrifileView.swift
//  Final
//
//  Created by dunice-internship on 17.11.2022.
//

import SwiftUI


struct PrifileView: View {
    @EnvironmentObject var viewModel: ViewModel
    var userIdUser:String
    var body: some View {
        
        VStack{
            
        AsyncImage(url: URL(string: viewModel.anatherUser!.avatar)!, scale: 2) { phase in
            if let image = phase.image { image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .customStyleImage()
            } else if phase.error != nil {
                Text("404!😢")
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                
            } else {
                ProgressView()
                    .font(.largeTitle)
            }
            
            Text(viewModel.anatherUser!.name)
          
                Text("Email:\(viewModel.anatherUser!.email)")
                Text("Role:\(viewModel.anatherUser!.role)")
           
            List {
                ForEach(viewModel.contentUser) { Content in
                    CellView(cell: Content)
                }
            }
        }
        }
        .onAppear{viewModel.getNewsUser(userId:userIdUser )}
        .padding()
        
        
    }
}

