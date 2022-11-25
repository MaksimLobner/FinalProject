//
//  CellView.swift
//  Final
//
//  Created by dunice-internship on 16.11.2022.
//
import Foundation
import SwiftUI

struct CellView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var cell: ContentNews
    @State var showingProfileView = false
    
    var body: some View {
            VStack{
                if cell.username == viewModel.user!.name{
                NavigationLink ("изменить", destination: ChangeNewsView(cell:cell))
                }
                Text(cell.username)
                    .bold()
                    .onTapGesture {
                        viewModel.getInfoAnatherUser(userId: cell.userID){
                        self.showingProfileView.toggle()
                        }
                    }
                    .sheet(isPresented: $showingProfileView) {
                        PrifileView(userIdUser: cell.userID)
                    }
                Text(cell.title)
                Text (cell.contentDescription)
                
                AsyncImage(url: URL(string: cell.image)!, scale: 2) { phase in
                    if let image = phase.image { image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                    } else if phase.error != nil {
                        Text("404!😢")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.center)
                        
                    } else {
                        ProgressView()
                            .font(.largeTitle)
                    }
                }
            }.padding()
        .swipeActions {
            Button {
                if cell.id != Int(viewModel.user!.id){
                    viewModel.content.removeAll{item in
                        item.id == cell.id
                    }
                    viewModel.deletePost(id:cell.id)
                }
            } label: {
                Text("delete")
            }
        }
    }
}

