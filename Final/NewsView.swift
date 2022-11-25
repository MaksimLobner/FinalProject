//
//  NewsView.swift
//  Final
//
//  Created by dunice-internship on 15.11.2022.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var viewModel : ViewModel
    @State private var searchText = ""
    @State var showingProfileView = false
    @State var searchField: String = ""
    @State var author: String = ""
    @State var keywords: String = ""
    @State var tags: [String]?
    @State var showToMyProfil: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $showToMyProfil) {
                PrifileView(userIdUser: viewModel.user!.id)
            } label: {
                Button {
                    self.showToMyProfil.toggle()
                    } label: {
                        Image("ava")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
            }
            TextField ("Find Post", text: $searchField)
                .padding(.horizontal)
            if searchField != ""{
                HStack{
                    Button {
                        author = searchField
                    } label: {
                        Text("add find author")
                            .customStyle()
                    }
                    Button {
                        keywords = searchField
                    } label: {
                        Text("add find description")
                            .customStyle()
                    }
                    Button {
                        tags?.append(searchField)
                    } label: {
                        Text("Add tag")
                            .customStyle()
                    }
                }
                HStack{
                    Text (author)
                    Text (keywords)
                    Text (tags?[0] ?? "")
                    Text (tags?[1] ?? "")
                    Text (tags?[2] ?? "")
                    Text (tags?[3] ?? "")
                    Text (tags?[4] ?? "")
                }
                HStack{
                    Button {
                        viewModel.getNews()
                    } label: {
                        Text("Show all news")
                            .customStyle()
                    }
                    Button {
                        viewModel.magiyaStrok(author: author, keywords: keywords, tags: tags ?? [""])
                    } label: {
                        Text("Find news")
                            .customStyle()
                    }
                    Button {
                        author = ""
                        keywords = ""
                        tags?[0] = ""
                    } label: {
                        Text("Clear search")
                            .customStyle()
                    }
                }
            }
            List {
                ForEach(viewModel.content) { Content in
                    CellView(cell: Content)
                }
            }
            NavigationLink ("Add Task", destination:CreateNewsView())
                .customStyleBigButton()
            
        }.onAppear{viewModel.getNews()}
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("news", displayMode: .inline)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(ViewModel())
    }
}
