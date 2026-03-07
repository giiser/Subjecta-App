import SwiftUI

struct SubjectsView: View {

    @StateObject private var viewModel = SubjectsViewModel()
    @EnvironmentObject var router: Router

    var body: some View {

        Group {

            if viewModel.isLoading {

                ProgressView()

            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)

            } else {

                List(viewModel.subjects) { subject in

                    Button {

                        router.navigateToTopics(subject: subject)

                    } label: {

                        VStack(alignment: .leading) {

                            Text(subject.title)
                                .font(.headline)

                            if let description = subject.description {

                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                            }

                        }

                    }

                }

            }

        }
        .navigationTitle("Subjects")
        .task {
            await viewModel.loadSubjects()
        }
    }
}
