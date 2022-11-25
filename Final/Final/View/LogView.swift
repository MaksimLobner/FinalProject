//
//  ContentView.swift
//  Final
//
//  Created by dunice-internship on 03.11.2022.
//

import SwiftUI


struct LogView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var forgotPasswordTap: Bool = false
    @State var emailField: String = ""
    @State var passwordField: String = ""
    @State var goToNewsList: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                TextField("Email", text: $emailField)
                    .customStyle()
                TextField("Pasword", text: $passwordField)
                    .customStyle()
                HStack(spacing: 3.0) {
                    Text ("Forgot password?")
                        .customStyle()
                        .onTapGesture {
                            self.forgotPasswordTap.toggle()
                        }
                    
                    NavigationLink ("Create new account",
                                    destination: {SingUpView()})
                        .customStyle()
                }
                Spacer()
                NavigationLink(isActive: $goToNewsList) {
                    NewsView()
                } label: {
                    Button {
                        viewModel.logUsers(email: emailField, password: passwordField) {
                            if viewModel.myToken != nil{
                                self.goToNewsList.toggle()
                            }
                        }
                    } label: {
                        Text ("LOGIN")
                            .customStyleBigButton()
                    }
                }
            }.padding()
                .navigationTitle(Text("My News"))
        }
    }
}


struct logView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
            .environmentObject(ViewModel())
    }
}
