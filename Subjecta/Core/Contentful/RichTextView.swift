//
//  RichTextView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import SwiftUI

struct RichTextView: View {

    let document: RichTextDocument

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            ForEach(document.content.indices, id: \.self) { index in

                render(node: document.content[index])

            }

        }
    }
    
    struct ParagraphNode: View {

        let node: RichNode

        var body: some View {

            Text(buildText())
                .font(.body)

        }

        private func buildText() -> AttributedString {

            var result = AttributedString()

            guard let children = node.content else { return result }

            for child in children {

                if let value = child.value {

                    var text = AttributedString(value)

                    if let marks = child.marks {

                        for mark in marks {

                            switch mark.type {

                            case "bold":
                                text.font = .body.bold()

                            case "italic":
                                text.inlinePresentationIntent = .emphasized

                            default:
                                break
                            }
                        }
                    }

                    result += text
                }

            }

            return result
        }
    }
    
    struct HeadingNode: View {

        let node: RichNode
        let level: Int

        var body: some View {

            Text(buildText())
                .font(font)

        }

        private var font: Font {

            switch level {

            case 1: return .title
            case 2: return .title2
            default: return .headline

            }

        }

        private func buildText() -> AttributedString {

            var result = AttributedString()

            guard let children = node.content else { return result }

            for child in children {

                if let value = child.value {

                    result += AttributedString(value)

                }

            }

            return result
        }
    }
    
    struct BulletListNode: View {

        let node: RichNode

        var body: some View {

            VStack(alignment: .leading, spacing: 8) {

                if let items = node.content {

                    ForEach(items.indices, id: \.self) { index in

                        HStack(alignment: .top) {

                            Text("•")

                            ParagraphNode(node: items[index])

                        }

                    }

                }

            }
        }
    }
    
    struct NumberedListNode: View {

        let node: RichNode

        var body: some View {

            VStack(alignment: .leading, spacing: 8) {

                if let items = node.content {

                    ForEach(items.indices, id: \.self) { index in

                        HStack(alignment: .top) {

                            Text("\(index + 1).")

                            ParagraphNode(node: items[index])

                        }

                    }

                }

            }
        }
    }
    
    struct BlockQuoteNode: View {

        let node: RichNode

        var body: some View {

            ParagraphNode(node: node)
                .italic()
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

        }
    }

    @ViewBuilder
    private func render(node: RichNode) -> some View {

        switch node.nodeType {

        case "paragraph":
            ParagraphNode(node: node)

        case "heading-1":
            HeadingNode(node: node, level: 1)

        case "heading-2":
            HeadingNode(node: node, level: 2)

        case "heading-3":
            HeadingNode(node: node, level: 3)

        case "unordered-list":
            BulletListNode(node: node)

        case "ordered-list":
            NumberedListNode(node: node)

        case "blockquote":
            BlockQuoteNode(node: node)

        default:
            EmptyView()

        }
    }
}
