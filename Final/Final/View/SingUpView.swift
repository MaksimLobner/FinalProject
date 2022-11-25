//
//  SingUpView.swift
//  Final
//
//  Created by dunice-internship on 03.11.2022.
//

import SwiftUI

struct SingUpView: View {
    @EnvironmentObject var viewModel : ViewModel
    @State private var image = UIImage()
    @State private var showSheet = false
    //MARK: -
    @State private var inputImage: UIImage?
    @State var nameField: String = ""
    @State var emailField: String = ""
    @State var passwordField: String = ""
    @State var avatar: String = "ava"
    @State var role : String = "user"
    //MARK: -
    var body: some View {
        VStack{
            VStack{
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .customStyleImage()
                
                Text("Change photo")
                    .customStyleBigButton()
                    .onTapGesture {
                        showSheet = true
                    }
            }.padding()
                .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
            Text ("Enter your email")
            TextField("Email", text: $emailField)
                .customStyle()
            Text ("What's your name")
            TextField("Name", text: $nameField)
                .customStyle()
            Text ("Think up a password")
            TextField("Password", text: $passwordField)
                .customStyle()
            Button(action: {viewModel.regUser(avatar: avatar, email: emailField, name: nameField, password: passwordField, role: role)
            })
            {
                Text ("create account")
                    .customStyleBigButton()
            }
        }.padding()
        .navigationTitle(Text("REGESTRACIYA"))
    }
}
//MARK: -
struct SingUpView_Previews: PreviewProvider {
    static var previews: some View {
        SingUpView()
            .environmentObject(ViewModel())
        
    }
}

