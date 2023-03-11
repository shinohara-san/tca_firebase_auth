//
//  LoginView.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginForm>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                TextField("email", text: viewStore.binding(\.$email))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                SecureField("password", text: viewStore.binding(\.$password))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)

                HStack {
                    Button("Login") {
                        viewStore.send(.loginButtonTapped)
                    }
                    .buttonStyle(.bordered)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button("Sign up") {
                        viewStore.send(.signUpButtonTapped)
                    }
                    .buttonStyle(.bordered)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(initialState: LoginForm.State(),
                         reducer: LoginForm())
        )
    }
}
