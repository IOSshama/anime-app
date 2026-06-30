//
//  CatalogFilterSheet.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct CatalogFilterSheet: View {
    private enum Constants {
        static let sectionSpacing: CGFloat = Spacing.lg
        static let chipSpacing: CGFloat = Spacing.sm
        static let chipGridMinWidth: CGFloat = 128
        static let yearLimit = 24
        static let actionBarSpacing: CGFloat = Spacing.ms
        static let actionBarTopOpacity: Double = 0.94
    }

    let filters: CatalogFiltersMeta
    let currentQuery: CatalogQuery
    let onApply: (CatalogQuery) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var draftQuery: CatalogQuery

    init(
        filters: CatalogFiltersMeta,
        currentQuery: CatalogQuery,
        onApply: @escaping (CatalogQuery) -> Void
    ) {
        self.filters = filters
        self.currentQuery = currentQuery
        self.onApply = onApply
        _draftQuery = State(initialValue: currentQuery)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                DesignTokens.Colors.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
                        sortSection
                        genreSection
                        typeSection
                        statusSection
                        yearSection
                    }
                    .padding(.horizontal, Spacing.ml)
                    .padding(.top, Spacing.md)
                    .padding(.bottom, Spacing.xxxl)
                }
            }
            .navigationTitle(StringResource.Catalog.filterTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(Typography.headline)
                    }
                    .accessibilityLabel(StringResource.Catalog.close)
                }
            }
            .safeAreaInset(edge: .bottom) {
                actionBar
            }
        }
        .preferredColorScheme(.dark)
    }

    private var sortSection: some View {
        filterSection(title: StringResource.Catalog.sortSection, systemImage: "arrow.up.arrow.down") {
            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Constants.chipSpacing) {
                ForEach(CatalogSortOption.allCases) { option in
                    FilterChip(
                        title: option.title,
                        systemImage: option.systemImage,
                        isSelected: draftQuery.sort == option.sort
                    ) {
                        draftQuery.sort = option.sort
                    }
                }
            }
        }
    }

    private var genreSection: some View {
        filterSection(title: StringResource.Catalog.genreSection, systemImage: "tag") {
            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Constants.chipSpacing) {
                FilterChip(
                    title: StringResource.Catalog.allGenres,
                    isSelected: draftQuery.genreSlug == nil
                ) {
                    draftQuery.genreSlug = nil
                }

                ForEach(filters.genres) { genre in
                    FilterChip(
                        title: genre.name,
                        isSelected: draftQuery.genreSlug == genre.id
                    ) {
                        draftQuery.genreSlug = genre.id
                    }
                }
            }
        }
    }

    private var typeSection: some View {
        filterSection(title: StringResource.Catalog.typeSection, systemImage: "rectangle.stack") {
            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Constants.chipSpacing) {
                FilterChip(
                    title: StringResource.Catalog.allTypes,
                    isSelected: draftQuery.type == nil
                ) {
                    draftQuery.type = nil
                }

                ForEach(availableTypes, id: \.self) { type in
                    FilterChip(
                        title: type.catalogTitle,
                        isSelected: draftQuery.type == type
                    ) {
                        draftQuery.type = type
                    }
                }
            }
        }
    }

    private var statusSection: some View {
        filterSection(title: StringResource.Catalog.statusSection, systemImage: "dot.radiowaves.left.and.right") {
            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Constants.chipSpacing) {
                FilterChip(
                    title: StringResource.Catalog.allStatuses,
                    isSelected: draftQuery.status == nil
                ) {
                    draftQuery.status = nil
                }

                ForEach(availableStatuses, id: \.self) { status in
                    FilterChip(
                        title: status.catalogTitle,
                        isSelected: draftQuery.status == status
                    ) {
                        draftQuery.status = status
                    }
                }
            }
        }
    }

    private var yearSection: some View {
        filterSection(title: StringResource.Catalog.yearSection, systemImage: "calendar") {
            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Constants.chipSpacing) {
                FilterChip(
                    title: StringResource.Catalog.anyYear,
                    isSelected: draftQuery.year == nil
                ) {
                    draftQuery.year = nil
                }

                ForEach(availableYears, id: \.self) { year in
                    FilterChip(
                        title: String(year),
                        isSelected: draftQuery.year == year
                    ) {
                        draftQuery.year = year
                    }
                }
            }
        }
    }

    private var actionBar: some View {
        HStack(spacing: Constants.actionBarSpacing) {
            Button {
                resetDraft()
            } label: {
                Text(StringResource.Catalog.resetFilters)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(AnimeButtonStyle(variant: .glass, height: Spacing.xxl, radius: CornerRadius.full))

            Button {
                onApply(draftQuery)
                dismiss()
            } label: {
                Text(StringResource.Catalog.applyFilters)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(AnimeButtonStyle(variant: .primary, height: Spacing.xxl, radius: CornerRadius.full))
        }
        .padding(.horizontal, Spacing.ml)
        .padding(.top, Spacing.ms)
        .padding(.bottom, Spacing.sm)
        .background(DesignTokens.Colors.background.opacity(Constants.actionBarTopOpacity))
    }

    private var chipColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: Constants.chipGridMinWidth), alignment: .leading)
        ]
    }

    private var availableTypes: [AnimeType] {
        filters.types.filter { $0 != .unknown }
    }

    private var availableStatuses: [AnimeStatus] {
        [.ongoing, .released, .announced]
    }

    private var availableYears: [Int] {
        guard filters.yearRange.max >= filters.yearRange.min else {
            return []
        }

        let lowerBound = max(filters.yearRange.min, filters.yearRange.max - Constants.yearLimit + 1)
        return Array((lowerBound...filters.yearRange.max).reversed())
    }

    private func filterSection<Content: View>(
        title: String,
        systemImage: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.ms) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: systemImage)
                    .font(Typography.captionSemibold)
                    .foregroundStyle(DesignTokens.Colors.primaryLink)

                Text(title)
                    .font(Typography.headline)
                    .foregroundStyle(DesignTokens.Colors.text)
            }

            content()
        }
    }

    private func resetDraft() {
        var query = CatalogQuery()
        query.pageSize = currentQuery.pageSize
        draftQuery = query
    }
}

private extension AnimeType {
    var catalogTitle: String {
        switch self {
        case .tv:
            StringResource.Meta.tv
        case .movie:
            StringResource.Meta.movie
        case .ova:
            StringResource.Meta.ova
        case .ona:
            StringResource.Meta.ona
        case .special:
            StringResource.Meta.special
        case .music:
            StringResource.Meta.music
        case .unknown:
            StringResource.Catalog.unknownOption
        }
    }
}

private extension AnimeStatus {
    var catalogTitle: String {
        switch self {
        case .announced:
            StringResource.Status.announced
        case .ongoing:
            StringResource.Status.ongoing
        case .released:
            StringResource.Status.released
        case .unknown:
            StringResource.Catalog.unknownOption
        }
    }
}
