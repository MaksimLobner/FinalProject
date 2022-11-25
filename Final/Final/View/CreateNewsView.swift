//
//  CreateNewsView.swift
//  Final
//
//  Created by dunice-internship on 16.11.2022.
//

import SwiftUI

struct CreateNewsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : ViewModel
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var titleField: String = ""
    @State private var contentDescriptionField: String = ""
    @State private var tagsField: [String] = [""]
    
    var body: some View {
        
        VStack{
            Text ("Share news with friends")
                .bold()
        TextField("Title", text: $titleField)
                .customStyle()
        TextField("contentDescription", text: $contentDescriptionField)
                .customStyle()
        TextField("tags", text: $tagsField[0])
                .customStyle()
        Image(uiImage: self.image)
            .resizable()
            .padding(.all, 4)
            .frame(width: 250, height: 250)
            .background(Color.black.opacity(0.2))
            .aspectRatio(contentMode: .fill)
            .padding(8)
            .onTapGesture {
                    showSheet = true
                }
            Button {
                viewModel.createNewPost(description: contentDescriptionField, image: "https://www.meme-arsenal.com/memes/648003cce36ca778e632751b1709abea.jpg", tags: tagsField, title: titleField)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("create")
            }
        }
        .padding()
        .navigationTitle(Text("Create Post"))
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
}
}
