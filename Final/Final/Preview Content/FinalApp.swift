//
//  FinalApp.swift
//  Final
//
//  Created by dunice-internship on 03.11.2022.
//

import SwiftUI

@main
struct FinalApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
           LogView()
               .environmentObject(viewModel)  
        }
    }
}
