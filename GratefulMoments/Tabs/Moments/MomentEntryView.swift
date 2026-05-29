//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/17.
//

import SwiftUI
import PhotosUI
import SwiftData
import UIKit

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State private var isShowingCancelConfirmation = false
    @State private var paywallSource: PaywallSource?
    @State private var entryAlert: EntryAlert?
    
    @Query private var moments: [Moment]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    @Environment(PurchaseManager.self) private var purchaseManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, note.isEmpty, imageData == nil {
                            dismiss()
                        } else {
                            isShowingCancelConfirmation = true
                        }
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation) {
                        Button("Discard Moment", role: .destructive) {
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        saveMoment()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .sheet(item: $paywallSource) { source in
                PaywallView(source: source)
            }
            .alert(item: $entryAlert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            loadPhoto(newImage)
        }
    }
    
    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)
            Divider()
            
            TextField("Log your small wins", text: $note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
            
            photoPicker
        }
        .padding()
    }
    
    private func saveMoment() {
        guard purchaseManager.hasPremium || moments.count < PurchaseManager.freeMomentLimit else {
            paywallSource = .momentLimit
            return
        }
        
        let newMoment = Moment(
            title: title,
            note: note,
            imageData: imageData,
            timestamp: .now
        )
        dataContainer.context.insert(newMoment)
        do {
            try dataContainer.badgeManager.unlockBadges(newMoment: newMoment)
            try dataContainer.context.save()
            dismiss()
        } catch {
            dataContainer.context.rollback()
            entryAlert = EntryAlert(
                title: "Save Failed",
                message: "Your moment could not be saved. Please try again."
            )
        }
    }

    private func loadPhoto(_ item: PhotosPickerItem) {
        Task {
            do {
                guard let selectedImageData = try await item.loadTransferable(type: Data.self) else {
                    return
                }
                imageData = try Self.preparedImageData(from: selectedImageData)
            } catch {
                entryAlert = EntryAlert(
                    title: "Photo Unavailable",
                    message: "Photo could not be added. Please choose another photo."
                )
            }
        }
    }

    private static func preparedImageData(from data: Data) throws -> Data {
        guard let image = UIImage(data: data) else {
            throw PhotoPreparationError.invalidImage
        }

        let preparedImage = image.resizedToFit(maxDimension: 1600)
        guard let jpegData = preparedImage.jpegData(compressionQuality: 0.82) else {
            throw PhotoPreparationError.compressionFailed
        }

        return jpegData
    }
}

private struct EntryAlert: Identifiable {
    let id = UUID()
    let title: LocalizedStringResource
    let message: LocalizedStringResource
}

private enum PhotoPreparationError: Error {
    case invalidImage
    case compressionFailed
}

private extension UIImage {
    func resizedToFit(maxDimension: CGFloat) -> UIImage {
        let longestSide = max(size.width, size.height)
        guard longestSide > maxDimension else {
            return normalizedForStorage()
        }

        let scale = maxDimension / longestSide
        let targetSize = CGSize(width: size.width * scale, height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: .storageImageFormat)

        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    func normalizedForStorage() -> UIImage {
        guard imageOrientation != .up else { return self }

        let renderer = UIGraphicsImageRenderer(size: size, format: .storageImageFormat)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

private extension UIGraphicsImageRendererFormat {
    static var storageImageFormat: UIGraphicsImageRendererFormat {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        return format
    }
}

#Preview {
    MomentEntryView()
        .sampleDataContainer()
}
