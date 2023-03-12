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
                    .modifier(TextFieldModifier())
                SecureField("password", text: viewStore.binding(\.$password))
                    .modifier(TextFieldModifier())

                HStack {
                    NavigationLink(
                        destination: MainView(
                            store: Store(initialState: Main.State(),
                                         reducer: Main())),
                        isActive: viewStore.binding(
                            get: \.isNavigationActive,
                            send: LoginForm.Action.setNavigation(isActive:))) {
                        Button("Login") {
                            viewStore.send(.loginButtonTapped)
                        }
                        .modifier(ButtonModifier(backgroundColor: .blue))
                    }

                    Button("Sign up") {
                        viewStore.send(.signUpButtonTapped)
                    }
                    .modifier(ButtonModifier(backgroundColor: .green))
                }
            }
            .padding()
            .alert(self.store.scope(state: \.alert),
                   dismiss: .alertDismissed)
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

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
    }
}

struct ButtonModifier: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
