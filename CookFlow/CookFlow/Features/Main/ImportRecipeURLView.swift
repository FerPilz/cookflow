import SwiftUI

struct ImportRecipeURLView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
    @ObservedObject var userRecipesStore: UserRecipesStore

    @State private var urlText = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var importedRecipe: Recipe?
    @State private var showRecipeDetail = false

    private let importService = RecipeImportService()

    var body: some View {
        let colors = themeManager.palette

        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                    Text("Import Recipe URL")
                        .font(DesignSystem.Fonts.screenTitle)
                        .foregroundColor(colors.primaryText)

                    urlField(label: "Recipe URL", placeholder: "https://example.com/recipe", text: $urlText)

                    if let errorMessage {
                        Text(errorMessage)
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(.red.opacity(0.9))
                    }

                    if isLoading {
                        HStack(spacing: DesignSystem.Spacing.sm) {
                            ProgressView()
                                .tint(DesignSystem.Colors.ctaGreen)
                            Text("Importing recipe...")
                                .font(DesignSystem.Fonts.valueProp)
                                .foregroundColor(colors.secondaryText)
                        }
                    }

                    PrimaryButton(title: "Import", isEnabled: canImport && !isLoading) {
                        Task { await importRecipe() }
                    }
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, DesignSystem.Spacing.lg)
            }
            .background(colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(colors.primaryText)
                }
            }
            .navigationDestination(isPresented: $showRecipeDetail) {
                if let importedRecipe {
                    RecipeDetailView(recipe: importedRecipe)
                }
            }
        }
    }

    private var canImport: Bool {
        guard let url = URL(string: urlText.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            return false
        }
        return url.scheme?.hasPrefix("http") == true && !(url.host ?? "").isEmpty
    }

    private func urlField(label: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text(label)
                .font(DesignSystem.Fonts.stepLabel)
                .foregroundColor(DesignSystem.Colors.textMuted)

            TextField(placeholder, text: text)
                .font(DesignSystem.Fonts.body)
                .foregroundColor(DesignSystem.Colors.primaryText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .keyboardType(.URL)
                .tint(DesignSystem.Colors.accent)
                .padding(DesignSystem.Spacing.md)
                .background(DesignSystem.Colors.card)
                .cornerRadius(DesignSystem.Radius.standard)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.standard)
                        .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                )
        }
    }

    @MainActor
    private func importRecipe() async {
        errorMessage = nil
        let trimmed = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: trimmed), url.scheme?.hasPrefix("http") == true, let host = url.host, !host.isEmpty else {
            errorMessage = "Please enter a valid recipe URL."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let dto = try await importService.importRecipe(from: url)
            let recipe = userRecipesStore.addImportedRecipe(dto)
            importedRecipe = recipe
            showRecipeDetail = true
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "We could not import this recipe."
        }
    }
}

#Preview {
    ImportRecipeURLView(userRecipesStore: UserRecipesStore())
        .environmentObject(ThemeManager(theme: .light))
        .preferredColorScheme(.light)
}
