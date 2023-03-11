//
//  tca_firebase_loginApp.swift
//  tca_firebase_login
//
//  Created by shinohara.yuki.2250 on 2023/03/11.
//

import SwiftUI
import FirebaseCore
import ComposableArchitecture

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct tca_firebase_loginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView(store: Store(
                    initialState: LoginForm.State(),
                    reducer: LoginForm()
                ))
            }
        }
    }
}
