//
//  RootView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: Router

    var body: some View {

        NavigationStack(path: $router.path) {

            Group {

                if authManager.isAuthenticated {
                    SubjectsView()
                } else {
                    LoginView()
                }

            }
            .navigationDestination(for: Route.self) { route in

                switch route {

                case .topics(let subject):
                    TopicsView(subject: subject)

                case .lessons(let topic):
                    LessonsView(topic: topic)

                case .lesson(let lessonId):
                    LessonDetailView(lessonId: lessonId)
                    
                case .quiz(let lessonId):
                    QuizView(lessonId: lessonId)
                }

            }
        }
    }
}
