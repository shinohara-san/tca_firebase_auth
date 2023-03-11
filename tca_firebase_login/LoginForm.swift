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
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case loginButtonTapped
        case signUpButtonTapped
        case loginResponse(TaskResult<Bool>)
        case signUpResponse(TaskResult<Bool>)
    }

    @Dependency(\.firebaseClient) var firebaseClient

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .loginButtonTapped:
                return .task { [email = state.email, password = state.password] in
                    await .loginResponse( TaskResult { try await self.firebaseClient.login(email, password) } )
                }
            case .signUpButtonTapped:
                return .task { [email = state.email, password = state.password] in
                    await .signUpResponse( TaskResult { try await self.firebaseClient.signup(email, password) } )
                }
            case let .loginResponse(isSuccessful):
                print(isSuccessful)
                return .none
            case let .signUpResponse(isSuccessful):
                print(isSuccessful)
                return .none
            }

        }
    }
}
