//
//  TopicsView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import SwiftUI

struct TopicsView: View {

    let subject: Subject

    @StateObject private var viewModel = TopicsViewModel()

    @EnvironmentObject var router: Router

    var body: some View {

        List(viewModel.topics) { topic in

            Button {

                router.navigateToLessons(topic: topic)

            } label: {

                VStack(alignment: .leading) {

                    Text(topic.title)
                        .font(.headline)

                    if let description = topic.description {

                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                    }

                }

            }

        }
        .navigationTitle(subject.title)
        .task {

            await viewModel.loadTopics(subjectId: subject.id)

        }

    }

}
