import SwiftUI

struct LessonsView: View {

    let topic: Topic

    @StateObject private var viewModel = LessonsViewModel()
    @EnvironmentObject var router: Router

    var body: some View {

        Group {

            if viewModel.isLoading {

                ProgressView()

            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)

            } else {

                List(viewModel.lessons) { item in

                    Button {

                        router.navigateToLesson(item.lesson)

                    } label: {

                        HStack {

                            VStack(alignment: .leading, spacing: 4) {

                                Text(item.lesson.title)
                                    .font(.headline)

                                if let summary = item.lesson.summary {

                                    Text(summary)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                }

                            }

                            Spacer()

                            if item.locked {

                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)

                            }

                        }

                    }
                }

            }

        }
        .navigationTitle(topic.title)
        .task {

            await viewModel.loadLessons(topicId: topic.id)

        }

    }

}
