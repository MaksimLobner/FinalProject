////
////  Repository.swift
////  Final
////
////  Created by dunice-internship on 15.11.2022.
////
//
import Foundation
import Alamofire
//
//
//
class Repository{
    // MARK: - Reg Request
    public func regUser (avatar: String, email: String, name: String, password: String, role: String){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/auth/register") else { fatalError("Missing URL") }
        let parameters = ["avatar": avatar, "email": email, "name": name, "password": password, "role": role]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(LogIn.self, from: data)
                print(json)
            }
            catch{
                print("error")
            }
        }.resume()
    }
    
// MARK: - Login Request
    public func logUser(email: String, password: String, onComplete: @escaping (LogIn) -> ()) {
        // Prepare URL
        let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/auth/login")
        guard let requestUrl = url else {
            print("postLogin: Bad URL")
            return
        }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let dataUser: Parameters = ["email": email,
                                    "password": password]
        // Set HTTP Request Body
        request.httpBody = try? JSONSerialization.data(withJSONObject: dataUser, options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            guard let data = data, error == nil else {
                print("postLogin: Error took place: \(String(describing: error))")
                return
            }
            do {
                // Convert HTTP Response Data to a Struct
                let decodedUsers = try JSONDecoder().decode(LogIn.self, from: data)
                //                print(decodedUsers)
                DispatchQueue.main.async {
                    onComplete(decodedUsers)
                }
                // Return main
            }
            catch let parseError {
                print("postLogin: \(parseError)")
            }
        }
        // Start Session
        task.resume()
    }
//MARK: - File Upload Request
    public func postUploadFile(image: UIImage) async throws -> PhotoData? {
        // Prepare URL
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/file/uploadFile") else { return nil }
        // Parse Image
        guard let imageData = image.pngData() else {
            print("postUploadFile: Error with image converting")
            return nil
        }
        // Data: returned structure
        var data: PhotoData?
        // Perform HTTP Requests
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<Void, Error>) in
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
            }, to: url, headers: nil)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PhotoData.self) { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        data = response.value
                        continuation.resume()
                    case .failure:
                        continuation.resume()
                    }
                }
        }
        return data
    }
//MARK: -GET NEws Request
    public func getItem(onComplete: @escaping (Welcome) -> ()){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/news?page=1&perPage=55") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let decodedUsers = try JSONDecoder().decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
                        onComplete(decodedUsers)
                    }
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
//MARK: - Create New News Request
    public func createNewPost (description: String, image: String, tags: [String], title: String, myToken: String) {
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/news") else { fatalError("Missing URL") }
        let parameters: Parameters = ["description": description,
                                      "image": image,
                                      "tags": tags,
                                      "title": title]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(myToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch{
                print("error")
            }
        }.resume()
    }
//MARK: - Delet Post Request
    public func deletePost (id : Int, myToken: String){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/news/\(id)")
        else { fatalError("Missing URL") }
        let parameters: Parameters = ["id": id]
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue(myToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch{
                print("error")
            }
        }.resume()
    }
//MARK: - CHANGE Post Request
    public func changePost (id : Int, description: String, image: String, tags: [String], title: String, myToken: String){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/news/\(id)") else { fatalError("Missing URL") }
        let parameters = ["description": description,
                          "image": image,
                          "tags": tags,
                          "title": title] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue(myToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch{
                print("error")
            }
        }.resume()
    }
//MARK: - Get News User Request
    public func getNewsUser(userId: String, myToken: String, onComplete: @escaping (Welcome) -> ()){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/news/user/\(userId)?page=1&perPage=30") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(myToken, forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let decodedUsers = try JSONDecoder().decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
                        onComplete(decodedUsers)
                    }
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
//MARK: - Find News Request
    public func findNews (urlString: String, myToken: String, onComplete: @escaping (FindNews) -> ()){
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(myToken, forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let decodedUsers = try JSONDecoder().decode(FindNews.self, from: data)
                    DispatchQueue.main.async {
                        onComplete(decodedUsers)
                    }
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
//MARK: - Get Info Anather User
    public func getInfoAnatherUser(userId: String, myToken: String, onComplete: @escaping (AnotherUser) -> ()){
        guard let url = URL(string: "https://news-feed.dunice-testing.com/api/v1/user/\(userId)") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(myToken, forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let decodedUsers = try JSONDecoder().decode(AnotherUser.self, from: data)
                    DispatchQueue.main.async {
                        onComplete(decodedUsers)
                    }
                } catch let error {
                    print("Error decoding: ", error)
                }
            }
        }
        dataTask.resume()
    }
}

var repository = Repository()









