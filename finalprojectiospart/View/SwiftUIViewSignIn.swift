//
//  SwiftUIViewSignIn.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI
import FirebaseAuth

struct SwiftUIViewSignIn: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(8 )
                    })
                    
                    NavigationLink("Create Account", destination: SwiftUIViewSignUp())
                        .padding()
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Welcome to NPA")
    }
}

struct SwiftUIViewSignIn_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewSignIn()
    }
}
