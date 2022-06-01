//
//  SwiftUIViewSignUp.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI
import FirebaseAuth

struct SwiftUIViewSignUp: View {
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
                        
                        viewModel.signUp(email: email, password: password)
                    }, label: {
                        Text("Register")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(8 )
                    })
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Hello, newbie!")
    }
}

struct SwiftUIViewSignUp_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewSignUp()
    }
}
