//
//  MLPListView.swift
//  MyLittlePony
//
//  Created by Berat Demir on 6.01.2025.
//

import SwiftUI

struct MLPListView: View, Routeable {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var presentationRouter: PresentationRouter<MLPListViewRouter>
    @EnvironmentObject var navigationRouter: NavigationRouter

    let characters: [PonyCharacter] = [
        PonyCharacter(
            name: "Twilight Sparkle",
            description: "The Princess of Friendship and a natural leader."),
        PonyCharacter(
            name: "Rainbow Dash", description: "A fast and daring pegasus with a loyal heart."),
        PonyCharacter(name: "Fluttershy", description: "A kind and gentle pony who loves animals."),
        PonyCharacter(
            name: "Pinkie Pie", description: "The life of the party with boundless energy."),
        PonyCharacter(
            name: "Rarity",
            description: "A glamorous and generous unicorn with a flair for fashion."),
        PonyCharacter(
            name: "Applejack",
            description: "A hardworking and dependable pony from Sweet Apple Acres."),
    ]

    var body: some View {
        VStack {
            List {
                TabView {
                    ForEach(characters) { content in
                        AsyncImage(url: URL(string: "https://picsum.photos/400/300")!)
                            .accessibilityIdentifier(content.accessId)
                            .accessibilityElement()
                    }
                }
                .tabViewStyle(.page)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 200)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .accessId(AccessibilityIdentifier.ListView.carousel)

                ForEach(characters) { character in
                    HStack {
                        Image(.pinkiePie)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 3)
                            .accessibilityAddTraits(.isImage)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(character.name)
                                .font(.headline)
                                .foregroundColor(Color.buttonPurple)
                                .accessId(AccessibilityIdentifier.ListView.header)
                                .accessibilityAddTraits(.isHeader)
                            Text(character.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .accessId(AccessibilityIdentifier.ListView.info)
                                .accessibilityAddTraits(.isSummaryElement)

                        }
                        Spacer(minLength: .zero)
                    }
                    .padding(.vertical, 5)
                    .accessibilityIdentifier(character.accessId)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowBackground(EmptyView())
        .mlpExpand(axis: [.horizontal, .vertical])
        .background(MLPBackgroundView())
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Toolbar {
                dismiss()
            }
        }
    }
}

private struct Toolbar: ToolbarContent {

    @EnvironmentObject
    private var sessionManager: SessionManager
    let dismiss: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("My Little Pony List")
                .fontWeight(.bold)
                .foregroundColor(Color.titlePink)
                .accessId(AccessibilityIdentifier.ListView.title)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                sessionManager.logout()
            } label: {
                Image(systemName: "power")
                    .foregroundColor(.black)
                    .padding()
            }
            .accessId(AccessibilityIdentifier.ListView.logout)
        }
    }
}

#Preview {
    EntryPointView()
        .environmentObject(SessionManager())

}
extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
