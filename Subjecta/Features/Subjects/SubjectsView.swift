//
//  SubjectsView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import SwiftUI

struct SubjectsView: View {

    @StateObject private var viewModel = SubjectsViewModel()

    var body: some View {

        NavigationStack {

            Group {

                if viewModel.isLoading {

                    ProgressView()

                } else if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundColor(.red)

                } else {

                    List(viewModel.subjects) { subject in

                        HStack {

                            Circle()
                                .fill(Color(hex: subject.themeColor ?? "#CCCCCC") ?? .gray)
                                .frame(width: 12, height: 12)

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
}
