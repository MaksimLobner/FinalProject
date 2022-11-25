//
//  CustomModifire.swift
//  Final
//
//  Created by dunice-internship on 17.11.2022.
//

import Foundation
import SwiftUI

   
struct CustomStyleImage:ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(50)
            .frame(width: 100, height: 100)
            .background(Color.black.opacity(0.2))
            .clipShape(Circle())
            .padding(8)
    }
}

struct CustomStyle:ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame( height: 40)
            .background(Color(.init(red: 0.2, green: 0.1, blue: 0.1, alpha: 0.1)))
            .cornerRadius(10)
            .foregroundColor(.black)
    }
}
struct CustomStyleBigButton:ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
            .foregroundColor(.white)
            .padding()
    }
}

extension View {
    func customStyle() -> some View{
        self.modifier(CustomStyle())
    }
    func customStyleBigButton() -> some View{
        self.modifier(CustomStyleBigButton())
        
    }
    func customStyleImage() -> some View{
        self.modifier(CustomStyleImage())
    }
}

