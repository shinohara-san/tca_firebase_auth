//
//  Main.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/12.
//

import ComposableArchitecture
import FirebaseAuth

struct Main: ReducerProtocol {
    struct State: Equatable {
        var alert: AlertState<Action>?
        var isSheetPresented: Bool = false
    }

    enum Action: Equatable {
        case logOutButtonTapped
        case logOut
        case logOutResponse(TaskResult<Bool>)
        case alertDismissed
        case setSheet(isPresented: Bool)
    }

    @Dependency(\.firebaseClient) var firebaseClient

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .logOutButtonTapped:
            state.alert = AlertState {
                TextState("Log out")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("Cancel")
                }
                ButtonState(action: .logOut) {
                    TextState("Log out")
                }
            } message: {
                TextState("Are you sure to log out?")
            }
            return .none
        case .logOut:
            return .task { [] in
                await .logOutResponse( TaskResult { try self.firebaseClient.logout()} ) // temp
            }
        case .logOutResponse(.success):
            state.isSheetPresented = true
            return .none
        case .logOutResponse(.failure):
            state.alert = AlertState{ TextState("Logout failed!") }
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        case .setSheet(isPresented: true):
            return .none
        case .setSheet(isPresented: false):
            state.alert = AlertState{ TextState("Logout failed!") } // temp
            return .none
        }
    }
}
