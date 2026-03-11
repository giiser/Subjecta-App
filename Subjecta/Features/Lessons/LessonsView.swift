import SwiftUI

struct LessonsView: View {

    let topic: Topic

    @StateObject private var viewModel = LessonsViewModel()
    @EnvironmentObject var router: Router
    @State private var showLockedAlert = false

    var body: some View {

        Group {

            if viewModel.isLoading {

                ProgressView()

            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)

            } else {
                
                VStack(spacing: 16) {

                    progressView

                    List(viewModel.lessons) { item in

                        Button {

                            if item.locked {
                                showLockedAlert = true
                                return
                            }

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

                                let state = lessonState(index: viewModel.lessons.firstIndex(where: { $0.id == item.id }) ?? 0)

                                switch state {

                                case .completed:

                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)

                                case .current:

                                    Image(systemName: "play.circle.fill")
                                        .foregroundColor(.blue)

                                case .locked:

                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.gray)

                                }

                            }
                            .opacity(item.locked ? 0.5 : 1)

                        }

                    }

                }

            }

        }
        .navigationTitle(topic.title)
        .alert("Lesson Locked",
               isPresented: $showLockedAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Complete the previous lesson to unlock this one.")
        }
        .task {

            await viewModel.loadLessons(topicId: topic.id)

        }

    }
    
    private var progressView: some View {

        let total = viewModel.lessons.count
        let unlocked = viewModel.lessons.filter { !$0.locked }.count

        return HStack(spacing: 8) {

            ForEach(0..<total, id: \.self) { index in

                Circle()
                    .fill(index < unlocked ? Color.green : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)

            }

        }
    }
    
    private func lessonState(index: Int) -> LessonState {

        let item = viewModel.lessons[index]

        if item.locked {
            return .locked
        }

        let firstLockedIndex = viewModel.lessons.firstIndex { $0.locked }

        if let firstLockedIndex {

            if index < firstLockedIndex - 1 {
                return .completed
            }

            if index == firstLockedIndex - 1 {
                return .current
            }

        }

        return .completed
    }
    
    enum LessonState {
        case completed
        case current
        case locked
    }

}
