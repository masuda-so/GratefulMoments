//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/18.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
    @State private var showCreateMoment = false
    @State private var paywallSource: PaywallSource?
    @State private var isShowingExportOptions = false
    @State private var exportedFile: ExportedMomentFile?
    @State private var exportErrorMessage: String?
    @State private var isExporting = false
    
    @Query(sort: \Moment.timestamp)
    private var moments: [Moment]
    @Environment(PurchaseManager.self) private var purchaseManager
    
    static let offsetAmount: CGFloat = 70.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 8, pinnedViews: .sectionHeaders) {
                    Section {
                        pathItems
                            .frame(maxWidth: .infinity)
                    } header: {
                        streakHeader
                    }
                }
            }
            .overlay {
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        handleExport()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(moments.isEmpty || isExporting)
                    
                    Button {
                        handleCreateMoment()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreateMoment) {
                MomentEntryView()
            }
            .sheet(item: $paywallSource) { source in
                PaywallView(source: source)
            }
            .sheet(item: $exportedFile) { exportedFile in
                ActivityView(activityItems: [exportedFile.url])
            }
            .confirmationDialog("Export Moments", isPresented: $isShowingExportOptions) {
                Button("PDF") {
                    exportMoments(as: .pdf)
                }
                Button("CSV") {
                    exportMoments(as: .csv)
                }
            } message: {
                Text("Choose an export format.")
            }
            .alert("Export Failed", isPresented: isShowingExportError) {
                Button("OK", role: .cancel) {
                }
            } message: {
                Text(exportErrorMessage ?? "Please try again.")
            }
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .defaultScrollAnchor(.top, for: .alignment)
            .navigationTitle("Grateful Moments")
        }
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
    
    private var pathItems: some View {
        ForEach(Array(moments.enumerated()), id: \.0) { index, moment in
            NavigationLink {
                MomentDetailView(moment: moment)
            } label: {
                if moment == moments.last {
                    MomentHexagonView(moment: moment, layout: .large)
                } else {
                    MomentHexagonView(moment: moment)
                        .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)
                }
            }
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
        }
    }

    @ViewBuilder private var streakHeader: some View {
        let streak = StreakCalculator().calculateStreak(for: moments)
        if streak > 0 {
            HStack {
                Text(verbatim: "\(streak)")
                Text(Image(systemName: "flame.fill"))
                    .foregroundStyle(.ember)
                Spacer()
            }
            .font(.subheadline)
            .padding()
        }
    }

    private var isShowingExportError: Binding<Bool> {
        Binding {
            exportErrorMessage != nil
        } set: { isShowing in
            if !isShowing {
                exportErrorMessage = nil
            }
        }
    }
    
    private func handleCreateMoment() {
        if purchaseManager.hasPremium || moments.count < PurchaseManager.freeMomentLimit {
            showCreateMoment = true
        } else {
            paywallSource = .momentLimit
        }
    }
    
    private func handleExport() {
        if purchaseManager.hasPremium {
            isShowingExportOptions = true
        } else {
            paywallSource = .export
        }
    }
    
    private func exportMoments(as format: MomentExportFormat) {
        isExporting = true
        do {
            exportedFile = try ExportedMomentFile(
                url: MomentExporter.export(moments: moments, format: format)
            )
        } catch {
            exportErrorMessage = error.localizedDescription
        }
        isExporting = false
    }
}

#Preview {
    MomentsView()
        .sampleDataContainer()
}

#Preview("No moments") {
    MomentsView()
        .modelContainer(for: [Moment.self])
        .environment(DataContainer())
        .environment(PurchaseManager.previewFree)
}
