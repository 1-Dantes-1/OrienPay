//
//  UserViewModel.swift
//  NetManager
//
//  Created by Buzurg Rakhımzoda on 30.06.2023.
//

import Foundation
import Combine

class UserModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User = User(id: 0, name: "", surname: "", phone_numbers: "", age: "", authorized: false) {
        didSet {
            saveCurrentUser()
        }
    }
        
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        currentUser = loadCurrentUser()
    }
    
    // Load the current user from UserDefaults
    private func loadCurrentUser() -> User {
        guard let savedData = UserDefaults.standard.data(forKey: "CurrentUser"),
              let currentUser = try? JSONDecoder().decode(User.self, from: savedData) else {
            return User(id: 0, name: "", surname: "", phone_numbers: "", age: "", authorized: false)
        }
        return currentUser
    }
    
    // Save the current user to UserDefaults
    private func saveCurrentUser() {
        if let encodedData = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encodedData, forKey: "CurrentUser")
        }
    }
    func fetchData() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = decodedData
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func createUser(name: String, surname: String, phone_numbers:String, age:String) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/create") else {
            // Handle invalid URL
            return
        }
        
        // Create the user object
        let newUser = User(id: users.count+1, name: name, surname: surname, phone_numbers: phone_numbers, age: age, authorized: true)
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            // Convert the user object to JSON data
            let jsonData = try JSONEncoder().encode(newUser)
            
            // Attach the JSON data to the request
            request.httpBody = jsonData
            
            // Create a URLSession task for the request
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle the error
                    print(error.localizedDescription)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // Request is successful
                        // Handle the response data
                    } else {
                        // Request failed with an error status code
                    }
                }
            }.resume() // Start the task
        } catch {
            // Handle JSON encoding error
            print(error.localizedDescription)
        }
    }
    func deleteUser(withID id:Int){
        guard let url = URL(string: "http://127.0.0.1:8000/users/delete/\(id)") else {
            // Handle invalid URL
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle the error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 {
                    // User deleted successfully
                    print("User deleted successfully")
                } else {
                    // Handle other status codes if needed
                    print("Unexpected status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    func findUserByPhoneNumber(withPH phoneNumber: String)->User{
        for user in users {
            if user.phone_numbers == phoneNumber{
                print("Found \(user.name) with this Phone Number")
                return user
            }
        }
        print("Didnt Found User by this phone number and returned user with phone number")
        return User(id: 0, name: "", surname: "", phone_numbers: phoneNumber, age: "", authorized: false)
    }
    func editUser(user: User) {
        guard let index = users.firstIndex(where: { $0.id == user.id }) else {
            // Handle user not found
            print("User not found")
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/users/update/\(user.id)") else {
            // Handle invalid URL
            print("Invalid URL")
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(user) else {
            // Handle encoding error
            print("Encoding error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    // Handle non-success status code (e.g., show an error message)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    // Handle success completion (e.g., show a success message)
                    
                    print("User edited successfully")
                case .failure(let error):
                    // Handle failure completion (e.g., show an error message)
                    print("Error: \(error)")
                }
            } receiveValue: { editedUser in
                self.users[index].authorized = true
                self.users[index] = editedUser
            }
            .store(in: &cancellables)
    }
    
}

