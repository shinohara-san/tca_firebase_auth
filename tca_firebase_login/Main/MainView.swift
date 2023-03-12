//
//  MainView.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<Main>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                Text("You are logged in!")
                Button("Log out") {
                    viewStore.send(.logOutButtonTapped)
                }
                .modifier(ButtonModifier(backgroundColor: .red))
            }
            .alert(self.store.scope(state: \.alert),
                   dismiss: .alertDismissed)
            .fullScreenCover(
              isPresented: viewStore.binding(
                get: \.isSheetPresented,
                send: Main.Action.setSheet(isPresented:)
              )
            ) {
                LoginView(store: Store(initialState: LoginForm.State(),
                                       reducer: LoginForm()))
            }
        }
        .navigationTitle("Main View")
        .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(initialState: Main.State(),
                         reducer: Main())
        )
    }
}
