//
//  Router.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class Router: ObservableObject {

    @Published var path = NavigationPath()

    func navigateToTopics(subject: Subject) {
        path.append(Route.topics(subject))
    }

    func navigateToLessons(topic: Topic) {
        path.append(Route.lessons(topic))
    }
    
    func navigateToLesson(_ lesson: Lesson) {

        path.append(Route.lesson(lesson.id))

    }
    
    func navigateToQuiz(lessonId: String) {

        path.append(Route.quiz(lessonId))

    }

}
