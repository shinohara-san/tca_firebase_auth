//
//  LoginForm.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import ComposableArchitecture

struct LoginForm: ReducerProtocol {
    struct State: Equatable {
        @BindingState var email = ""
        @BindingState var password = ""
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case loginButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            case .loginButtonTapped:
                return .none
            }
        }
    }
}
