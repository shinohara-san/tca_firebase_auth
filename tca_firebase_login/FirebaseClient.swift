//
//  FirebaseClient.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import FirebaseAuth
import ComposableArchitecture

struct FirebaseClient {
    var login: @Sendable (String, String) async throws -> Bool
    var signup: @Sendable (String, String) async throws -> Bool
}

extension DependencyValues {
    var firebaseClient: FirebaseClient {
        get { self[FirebaseClient.self] }
        set { self[FirebaseClient.self] = newValue }
    }
}

extension FirebaseClient: DependencyKey {
    static let liveValue = Self(
        login: { email, password in
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let uid = result.user.uid
            return !uid.isEmpty
        }, signup: { email, password in
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = result.user.uid
            return !uid.isEmpty
        }
    )
}
