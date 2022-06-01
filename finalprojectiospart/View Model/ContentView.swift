//
//  ContentView.swift
//  finalprojectiospart
//
//  Created by Айбек on 22.05.2022.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
            return auth.currentUser != nil
    }

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil,  error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }

    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil,  error == nil else {
                return
        }
            DispatchQueue.main.async {
                    self?.signedIn = true
            }
        }
    }
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {

    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                NavigationLink(destination: SwiftUIViewTabBar(), label: {
                    VStack {
                    Text("Start")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .padding()
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Log Out")
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    })
                    }
                })
            }
            else {
                SwiftUIViewSignIn()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
