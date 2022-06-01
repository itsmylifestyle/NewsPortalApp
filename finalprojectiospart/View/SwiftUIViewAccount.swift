//
//  SwiftUIViewAccount.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI
import FirebaseAuth

 

struct SwiftUIViewAccount: View {
    @State var firstname = ""
    @State var lastname = ""
    
    var body: some View {
        VStack {
            Image("user")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            
            TextField("First name", text: $firstname)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .frame(width: 400)
            
            TextField("Last name", text: $lastname)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .frame(width: 400)

            }
        }
    }

struct SwiftUIViewAccount_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewAccount()
    }
}
