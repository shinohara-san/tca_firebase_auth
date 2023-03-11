//
//  LoginForm.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import ComposableArchitecture
import FirebaseAuth

struct LoginForm: ReducerProtocol {
    struct State: Equatable {
        @BindingState var email = ""
        @BindingState var password = ""
        var alert: AlertState<Action>?
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case loginButtonTapped
        case signUpButtonTapped
        case loginResponse(TaskResult<Bool>)
        case signUpResponse(TaskResult<Bool>)
        case alertDismissed
    }

    @Dependency(\.firebaseClient) var firebaseClient

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .loginButtonTapped:
                return .task { [email = state.email.trimmingCharacters(in: .whitespacesAndNewlines),
                                password = state.password.trimmingCharacters(in: .whitespacesAndNewlines)] in
                    await .loginResponse( TaskResult { try await self.firebaseClient.login(email, password) } )
                }
            case .signUpButtonTapped:
                return .task { [email = state.email.trimmingCharacters(in: .whitespacesAndNewlines),
                                password = state.password.trimmingCharacters(in: .whitespacesAndNewlines)] in
                    await .signUpResponse( TaskResult { try await self.firebaseClient.signup(email, password) } )
                }
            case let .loginResponse(_):
                // TODO: Navigate to MainView
                return .none
            case let .signUpResponse(.success(_)):
                state.alert = AlertState(title: {
                    TextState("Register succeeded!")
                }, message: {
                    TextState("Please login with your id and password.")
                })
                return .none
            case .signUpResponse(.failure):
                state.alert = AlertState(title: {
                    TextState("Register failed!")
                })
                return .none
            case .alertDismissed:
                state.alert = nil
                return .none
            }

        }
    }
}
