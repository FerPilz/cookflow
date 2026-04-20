//
//  AddRecipeView.swift
//  CookFlow
//
//  Created by Codex on 2/15/26.
//

import PhotosUI
import SwiftUI
import UIKit

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userRecipesStore: UserRecipesStore

    @State private var title = ""
    @State private var summary = ""
    @State private var ingredients = [""]
    @State private var instructions = [""]

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var isShowingCamera = false
    @State private var activeIngredientIndex: Int?

    private let suggestionSource = ShoppingSuggestionSource()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.lg) {
                    fieldLabel("Title")
                    textField("Recipe title", text: $title)

                    fieldLabel("Description")
                    textField("Short summary (optional)", text: $summary)

                    photoSection
                    ingredientsSection
                    instructionsSection
                }
                .padding(.horizontal, DesignSystem.Spacing.lg)
                .padding(.vertical, DesignSystem.Spacing.md)
            }
            .background(DesignSystem.Colors.backgroundNearBlack)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(DesignSystem.Colors.textCream)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: save)
                        .foregroundColor(canSave ? DesignSystem.Colors.ctaGreen : DesignSystem.Colors.textMuted)
                        .disabled(!canSave)
                }
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(DesignSystem.Colors.backgroundNearBlack, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .sheet(isPresented: $isShowingCamera) {
            CameraImagePicker(sourceType: .camera) { image in
                selectedImageData = image.jpegData(compressionQuality: 0.82)
            }
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            Task {
                await loadPhoto(from: newItem)
            }
        }
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !cleanedIngredients.isEmpty
            && !cleanedInstructions.isEmpty
    }

    private var cleanedIngredients: [String] {
        ingredients
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    private var cleanedInstructions: [String] {
        instructions
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    private var photoSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            fieldLabel("Photo")

            HStack(spacing: DesignSystem.Spacing.sm) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    photoActionButton(title: selectedImageData == nil ? "Upload Image" : "Change Image", systemName: "photo")
                }

                Button(action: { isShowingCamera = true }) {
                    photoActionButton(title: "Take Photo", systemName: "camera")
                }
                .buttonStyle(.plain)
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                .opacity(UIImagePickerController.isSourceTypeAvailable(.camera) ? 1 : 0.45)
            }

            if let imageData = selectedImageData, let image = UIImage(data: imageData) {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 168)
                        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))

                    Button(action: { selectedImageData = nil }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(DesignSystem.Colors.textCream)
                            .padding(10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                fieldLabel("Ingredients")
                Spacer()
                addRowButton(title: "Add Ingredient", action: addIngredientRow)
            }

            ForEach(Array(ingredients.indices), id: \.self) { index in
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                    editableRow(
                        placeholder: "Ingredient \(index + 1)",
                        text: Binding(
                            get: { ingredients[index] },
                            set: { ingredients[index] = $0 }
                        ),
                        removeAction: ingredients.count > 1 ? { removeIngredient(at: index) } : nil,
                        isMultiline: false,
                        onFocus: { activeIngredientIndex = index }
                    )

                    if activeIngredientIndex == index {
                        ingredientSuggestions(for: index)
                    }
                }
            }
        }
    }

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            HStack {
                fieldLabel("Instructions")
                Spacer()
                addRowButton(title: "Add Step", action: addInstructionRow)
            }

            ForEach(Array(instructions.indices), id: \.self) { index in
                editableRow(
                    placeholder: "Step \(index + 1)",
                    text: Binding(
                        get: { instructions[index] },
                        set: { instructions[index] = $0 }
                    ),
                    removeAction: instructions.count > 1 ? { removeInstruction(at: index) } : nil,
                    isMultiline: true,
                    onFocus: nil
                )
            }
        }
    }

    @ViewBuilder
    private func ingredientSuggestions(for index: Int) -> some View {
        let query = ingredients[index].trimmingCharacters(in: .whitespacesAndNewlines)
        let matches = suggestionSource.matches(for: query)

        if !query.isEmpty, !matches.isEmpty {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(matches) { suggestion in
                    Button(action: {
                        ingredients[index] = suggestion.name
                        activeIngredientIndex = nil
                    }) {
                        HStack {
                            Text(suggestion.name)
                                .font(DesignSystem.Fonts.valueProp)
                                .foregroundColor(DesignSystem.Colors.textCream)
                            Spacer()
                        }
                        .padding(.horizontal, DesignSystem.Spacing.md)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)

                    if suggestion.id != matches.last?.id {
                        Divider()
                            .overlay(DesignSystem.Colors.divider)
                    }
                }
            }
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
        }
    }

    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(DesignSystem.Fonts.valueProp)
            .foregroundColor(DesignSystem.Colors.textCream)
    }

    private func textField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .font(DesignSystem.Fonts.subtitle)
            .foregroundColor(DesignSystem.Colors.textCream)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .frame(height: 52)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
    }

    private func editableRow(
        placeholder: String,
        text: Binding<String>,
        removeAction: (() -> Void)?,
        isMultiline: Bool,
        onFocus: (() -> Void)?
    ) -> some View {
        HStack(alignment: isMultiline ? .top : .center, spacing: DesignSystem.Spacing.sm) {
            Group {
                if isMultiline {
                    TextField(placeholder, text: text, axis: .vertical)
                        .lineLimit(2...5)
                } else {
                    TextField(placeholder, text: text)
                        .onTapGesture { onFocus?() }
                }
            }
            .font(DesignSystem.Fonts.subtitle)
            .foregroundColor(DesignSystem.Colors.textCream)
            .textInputAutocapitalization(.sentences)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                    .stroke(DesignSystem.Colors.divider, lineWidth: 1)
            )
            .onChange(of: text.wrappedValue) { _, _ in
                onFocus?()
            }

            if let removeAction {
                Button(action: removeAction) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(DesignSystem.Colors.textMuted)
                }
                .buttonStyle(.plain)
                .padding(.top, isMultiline ? 14 : 0)
            }
        }
    }

    private func addRowButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text("+ \(title)")
                .font(DesignSystem.Fonts.valueProp)
                .foregroundColor(DesignSystem.Colors.ctaGreen)
        }
        .buttonStyle(.plain)
    }

    private func photoActionButton(title: String, systemName: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemName)
                .font(.system(size: 12, weight: .semibold))

            Text(title)
                .font(DesignSystem.Fonts.valueProp)
        }
        .foregroundColor(DesignSystem.Colors.ctaGreen)
        .padding(.horizontal, DesignSystem.Spacing.md)
        .padding(.vertical, DesignSystem.Spacing.sm)
        .frame(maxWidth: .infinity)
        .background(DesignSystem.Colors.card)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DesignSystem.Radius.standard, style: .continuous)
                .stroke(DesignSystem.Colors.divider, lineWidth: 1)
        )
    }

    private func addIngredientRow() {
        ingredients.append("")
        activeIngredientIndex = ingredients.count - 1
    }

    private func removeIngredient(at index: Int) {
        ingredients.remove(at: index)
        if activeIngredientIndex == index {
            activeIngredientIndex = nil
        }
    }

    private func addInstructionRow() {
        instructions.append("")
    }

    private func removeInstruction(at index: Int) {
        instructions.remove(at: index)
    }

    private func save() {
        userRecipesStore.addRecipe(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            summary: summary.trimmingCharacters(in: .whitespacesAndNewlines),
            ingredients: cleanedIngredients,
            instructions: cleanedInstructions,
            imageData: selectedImageData
        )

        dismiss()
    }

    private func loadPhoto(from item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        await MainActor.run {
            selectedImageData = data
        }
    }
}

#Preview {
    AddRecipeView(userRecipesStore: UserRecipesStore())
        .preferredColorScheme(.dark)
}
