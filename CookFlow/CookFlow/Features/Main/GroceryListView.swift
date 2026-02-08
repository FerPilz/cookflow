//
//  GroceryListView.swift
//  CookFlow
//
//  Created by Codex on 2/8/26.
//

import SwiftUI

struct GroceryListView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                DesignSystem.Colors.backgroundNearBlack
                    .ignoresSafeArea()

                Text("Coming soon")
                    .font(DesignSystem.Fonts.subtitle)
                    .foregroundColor(DesignSystem.Colors.textMuted)
            }
            .navigationTitle("Grocery List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(DesignSystem.Colors.textCream)
                }
            }
        }
    }
}

#Preview {
    GroceryListView()
        .preferredColorScheme(.dark)
}
