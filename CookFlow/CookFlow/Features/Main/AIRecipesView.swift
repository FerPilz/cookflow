import PhotosUI
import SwiftUI
import UIKit

struct AIRecipesView: View {
    @AppStorage("isPro") private var isPremium = false

    @State private var importURLText = ""
    @State private var importErrorMessage: String?
    @State private var importPreviewTitle: String?
    @State private var showFullImport = true

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var detectedIngredients: [String] = []
    @State private var suggestedRecipeTitle: String?
    @State private var showFullFridgeResults = true

    @State private var selectedNutritionRecipeID: String = ""
    @State private var nutritionEstimated = false
    @State private var showFullNutritionPlan = true

    @State private var showComingSoonAlert = false

    var body: some View {
        ZStack {
            DesignSystem.Colors.backgroundNearBlack
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    headerSection
                    webImportSection
                    fridgeSnapSection
                    nutritionSection
                    premiumBanner
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.top, DesignSystem.Spacing.md)
                .padding(.bottom, 104)
            }
        }
        .background(DesignSystem.Colors.backgroundNearBlack)
        .alert("Coming soon", isPresented: $showComingSoonAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This action is connected to subscriptions in a later phase.")
        }
        .onAppear {
            if selectedNutritionRecipeID.isEmpty {
                selectedNutritionRecipeID = nutritionRecipeOptions.first?.id ?? ""
            }
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            Task {
                await loadPhoto(from: newItem)
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("AI Kitchen")
                .font(DesignSystem.Fonts.screenTitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text("Sneak peek of Premium")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textMuted)
        }
    }

    private var webImportSection: some View {
        AIFeatureCard(
            title: "Web Recipe Import",
            description: "Paste a recipe URL and preview extraction.",
            systemImage: "link",
            ctaTitle: "Import Full Recipe",
            onTapCTA: { runPremiumAction { showFullImport = true } }
        ) {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                TextField("https://example.com/recipe", text: $importURLText)
                    .font(DesignSystem.Fonts.valueProp)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .autocorrectionDisabled(true)
                    .foregroundColor(DesignSystem.Colors.textCream)
                    .padding(.horizontal, DesignSystem.Spacing.md)
                    .frame(height: 44)
                    .background(DesignSystem.Colors.backgroundNearBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                    )

                Button(action: previewImport) {
                    Text("Preview Import")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(DesignSystem.Colors.backgroundNearBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)

                if let importErrorMessage {
                    Text(importErrorMessage)
                        .font(DesignSystem.Fonts.valueProp)
                        .foregroundColor(.red.opacity(0.9))
                }

                if let importPreviewTitle {
                    fullImportPreview(title: importPreviewTitle)
                }
            }
        }
    }

    private var fridgeSnapSection: some View {
        AIFeatureCard(
            title: "Fridge Snap",
            description: "Snap ingredients and preview recipe ideas.",
            systemImage: "camera.fill",
            ctaTitle: "Generate Full Recipe",
            onTapCTA: { runPremiumAction { showFullFridgeResults = true } }
        ) {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Text(selectedPhotoData == nil ? "Choose Fridge Photo" : "Change Photo")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(DesignSystem.Colors.backgroundNearBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )
                }

                if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                if !detectedIngredients.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Detected ingredients")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textCream)

                        ForEach(detectedIngredients.prefix(5), id: \.self) { item in
                            Text("• \(item)")
                                .font(DesignSystem.Fonts.valueProp)
                                .foregroundColor(DesignSystem.Colors.textMuted)
                        }
                    }
                }

                if let suggestedRecipeTitle {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Recipe options")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textCream)
                        Text("1. \(suggestedRecipeTitle)")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                        Text("2. Sheet-Pan Garlic Veggie Bake")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                        Text("3. Quick Protein Bowl")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textMuted)
                    }
                    .padding(DesignSystem.Spacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(DesignSystem.Colors.backgroundNearBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                    )
                }
            }
        }
    }

    private var nutritionSection: some View {
        AIFeatureCard(
            title: "Nutrition Coach",
            description: "Estimate macros and get smart swaps.",
            systemImage: "chart.bar.doc.horizontal",
            ctaTitle: "Get Full Nutrition Plan",
            onTapCTA: { runPremiumAction { showFullNutritionPlan = true } }
        ) {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
                Picker("Recipe", selection: $selectedNutritionRecipeID) {
                    ForEach(nutritionRecipeOptions) { recipe in
                        Text(recipe.title).tag(recipe.id)
                    }
                }
                .pickerStyle(.menu)
                .tint(DesignSystem.Colors.textCream)
                .padding(.horizontal, DesignSystem.Spacing.sm)
                .frame(height: 40)
                .background(DesignSystem.Colors.backgroundNearBlack)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                )

                Button(action: { nutritionEstimated = true }) {
                    Text("Estimate Nutrition")
                        .font(DesignSystem.Fonts.link)
                        .foregroundColor(DesignSystem.Colors.textCream)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(DesignSystem.Colors.backgroundNearBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)

                if nutritionEstimated {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Weekly plan")
                            .font(DesignSystem.Fonts.valueProp)
                            .foregroundColor(DesignSystem.Colors.textCream)
                        Text("• Goal: improve protein consistency")
                        Text("• Suggestion: pair each dinner with 25–35g protein")
                        Text("• Add one high-fiber swap three days this week")
                    }
                    .font(DesignSystem.Fonts.valueProp)
                    .foregroundColor(DesignSystem.Colors.textMuted)
                    .padding(DesignSystem.Spacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(DesignSystem.Colors.backgroundNearBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(DesignSystem.Colors.divider, lineWidth: 1)
                    )
                }
            }
        }
    }

    private var premiumBanner: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Unlock CookFlow Premium")
                .font(DesignSystem.Fonts.subtitle)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text("Import from the web, generate complete AI recipes, and unlock full nutrition plans.")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textMuted)

            SecondaryButton(title: "See Premium") {}
        }
        .padding(DesignSystem.Spacing.md)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private var nutritionRecipeOptions: [Recipe] {
        Array(SampleData.allRecipes.prefix(10))
    }

    private func runPremiumAction(unlockedAction: () -> Void) {
        unlockedAction()
    }

    private func previewImport() {
        let trimmed = importURLText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: trimmed), let host = url.host, !host.isEmpty else {
            importErrorMessage = "Please enter a valid recipe URL."
            importPreviewTitle = nil
            showFullImport = false
            return
        }

        importErrorMessage = nil
        let path = url.path
            .split(separator: "/")
            .last
            .map(String.init)
            ?? "recipe"

        let inferredTitle = path
            .replacingOccurrences(of: "-", with: " ")
            .replacingOccurrences(of: "_", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let titleCore = inferredTitle.isEmpty ? host : inferredTitle
        importPreviewTitle = "Imported Recipe: \(titleCore.capitalized)"
        showFullImport = false
    }

    private func fullImportPreview(title: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textCream)

            Text("Ingredients")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textCream)
            Text("• 12 oz pasta")
            Text("• 2 tbsp olive oil")
            Text("• 3 cloves garlic")
            Text("• 1 cup tomato sauce")

            Text("Steps")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.textCream)
            Text("1. Boil pasta until al dente.")
            Text("2. Saute garlic in olive oil.")
            Text("3. Add sauce, toss pasta, and finish with herbs.")
        }
        .font(DesignSystem.Fonts.valueProp)
        .foregroundColor(DesignSystem.Colors.textMuted)
        .padding(DesignSystem.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(DesignSystem.Colors.backgroundNearBlack)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func loadPhoto(from item: PhotosPickerItem?) async {
        showFullFridgeResults = false
        guard let item else {
            selectedPhotoData = nil
            detectedIngredients = []
            suggestedRecipeTitle = nil
            return
        }

        guard let data = try? await item.loadTransferable(type: Data.self) else {
            selectedPhotoData = nil
            detectedIngredients = []
            suggestedRecipeTitle = nil
            return
        }

        await MainActor.run {
            selectedPhotoData = data
            detectedIngredients = ["Tomatoes", "Spinach", "Chicken", "Greek Yogurt", "Lemon"]
            suggestedRecipeTitle = "Lemon Chicken Skillet"
        }
    }
}

#Preview {
    AIRecipesView()
        .preferredColorScheme(.dark)
}
