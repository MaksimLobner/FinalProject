//
//  ChangeNewsView.swift
//  
//
//  Created by dunice-internship on 18.11.2022.
//

import SwiftUI

struct ChangeNewsView: View {
    
    @State var cell: ContentNews
    @EnvironmentObject var viewModel : ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showSheet = false
    @State private var imageField = UIImage()
    
    @State private var titleField: String = ""
    @State private var contentDescriptionField: String = ""
    @State private var tagsField: [String] = [""]
    @State private var imageURL: String = "https://news-feed.dunice-testing.com/api/v1/file/ce9fa12b-91e3-4057-af02-18ce723a9479.png"
    
    
    
    var body: some View {
        VStack{
            TextField(cell.title, text: $titleField)
                .customStyle()
            TextField(cell.contentDescription, text: $contentDescriptionField)
                .customStyle()
            TextField("tags", text: $tagsField[0])
                .customStyle()
            AsyncImage(url: URL(string: cell.image)!, scale: 3) { phase in
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
            }.padding(.horizontal)

                .onTapGesture {
                    showSheet = true
                }
            Button {
                viewModel.changeNews(id: cell.id, description: contentDescriptionField, image: imageURL, tags: tagsField, title: titleField)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .customStyleBigButton()
            }
        }.padding()
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$imageField)
            }
    }
}
