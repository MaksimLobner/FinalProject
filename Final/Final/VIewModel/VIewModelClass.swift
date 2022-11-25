//
//  VIewModelClass.swift
//  Final
//
//  Created by dunice-internship on 08.11.2022.
//

import Foundation
import SwiftUI
import Alamofire

class ViewModel: ObservableObject {
    
    
    @Published var anatherUser: AnotherUserData?
    @Published var user : RegistrationUser?
    @Published var content = [ContentNews]()
    @Published var contentUser = [ContentNews]()
    var myToken: String?
    
    
    func regUser(avatar: String, email: String, name: String, password: String, role: String){
        repository.regUser(avatar: avatar, email: email, name: name, password: password, role: role)
    }
    
    func createAccount (avatar: String, email: String, name: String, password: String, role: String){
        repository.regUser(avatar: avatar, email: email, name: name, password: password, role: role)
    }
    func logUsers (email: String, password: String, onComplete: @escaping () -> () )  {
        repository.logUser(email: email, password: password){LogIn in
            self.user = LogIn.data
            self.myToken = LogIn.data.token
            onComplete()
        }
    }
    func postFile (image: UIImage) async throws -> PhotoData?{
        try await repository.postUploadFile(image: image)
    }
    func getNews () {
        repository.getItem { Welcome in
            self.content = Welcome.data.content
        }
    }
    func createNewPost(description: String, image: String, tags: [String], title: String) {
        repository.createNewPost(description: description, image: image, tags: tags, title: title, myToken: myToken!)
    }
    func deletePost(id: Int) {
        repository.deletePost(id: id, myToken: myToken!)
    }
    func changeNews (id: Int, description: String, image: String, tags: [String], title: String){
        repository.changePost(id: id, description: description, image: image, tags: tags, title: title, myToken: myToken!)
    }
    func getNewsUser (userId: String) {
        repository.getNewsUser(userId: userId, myToken: myToken!){Welcome in
            self.contentUser = Welcome.data.content
        }
    }
    func getInfoAnatherUser(userId: String, onComplete: @escaping () -> ()) {
        repository.getInfoAnatherUser(userId: userId, myToken: myToken!) { AnotherUser in
            self.anatherUser = AnotherUser.data
        
            
        }
    }
    func magiyaStrok(author: String, keywords: String, tags: [String]){
        var urlString: String = "https://news-feed.dunice-testing.com/api/v1/news/find?&page=1&perPage=5"
        if author != "" {
            urlString += "&author=\(author)"
        }
        if keywords != ""{
            urlString += "&keywords=\(keywords)"
        }
        if tags[0] != ""{
            urlString += "&tags=\(tags[0])"
        }
//        if tags[1] != nil{
//            urlString += "tags=\(tags[1])"
//        }
//        if tags[2] != nil{
//            urlString += "tags=\(tags[2])"
//        }
//        if tags[3] != nil{
//            urlString += "tags=\(tags[3])"
//        }
//        if tags[4] != nil{
//            urlString += "tags=\(tags[4])"
//        }
        
        repository.findNews(urlString: urlString, myToken: myToken!) {FindNews in
            self.content = FindNews.content
        }   
    }
    
    
    
    
    
    
    
    
}
