//
//  PreferencesView.swift
//  CookFlow
//
//  Created by Codex on 1/30/26.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var selectedPreferences: [String]
    @Binding var optimizationGoal: String

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Text("Preferences")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text("Selected: \(selectedPreferences.joined(separator: ", ").isEmpty ? "None" : selectedPreferences.joined(separator: ", "))")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)

            Text("Goal: \(optimizationGoal.isEmpty ? "Not set" : optimizationGoal)")
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
        .padding(.horizontal, DesignSystem.Spacing.xl)
    }
}

#Preview {
    PreferencesView(selectedPreferences: .constant([]), optimizationGoal: .constant(""))
}
