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
    }

    enum Action: Equatable {
        case logOutButtonTapped
        case logOutResponse(TaskResult<Bool>)
        case alertDismissed
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .logOutButtonTapped:
            return .none
        case .logOutResponse(.success):
            return .none
        case .logOutResponse(.failure):
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        }
    }
}
