//
//  FlowLayout.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = Spacing.sm
    var rowSpacing: CGFloat = Spacing.sm

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        layout(in: proposal.width ?? .infinity, subviews: subviews).size
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        for item in layout(in: bounds.width, subviews: subviews).items {
            subviews[item.index].place(
                at: CGPoint(x: bounds.minX + item.origin.x, y: bounds.minY + item.origin.y),
                proposal: ProposedViewSize(item.size)
            )
        }
    }

    private func layout(in width: CGFloat, subviews: Subviews) -> FlowLayoutResult {
        guard !subviews.isEmpty else {
            return FlowLayoutResult(size: .zero, items: [])
        }

        var origin = CGPoint.zero
        var lineHeight: CGFloat = .zero
        var maxWidth: CGFloat = .zero
        var items: [FlowLayoutItem] = []

        for index in subviews.indices {
            let size = subviews[index].sizeThatFits(.unspecified)

            if origin.x > .zero, origin.x + size.width > width {
                origin.x = .zero
                origin.y += lineHeight + rowSpacing
                lineHeight = .zero
            }

            items.append(FlowLayoutItem(index: index, origin: origin, size: size))
            lineHeight = max(lineHeight, size.height)
            maxWidth = max(maxWidth, origin.x + size.width)
            origin.x += size.width + spacing
        }

        return FlowLayoutResult(
            size: CGSize(width: maxWidth, height: origin.y + lineHeight),
            items: items
        )
    }
}

private struct FlowLayoutResult {
    let size: CGSize
    let items: [FlowLayoutItem]
}

private struct FlowLayoutItem {
    let index: Int
    let origin: CGPoint
    let size: CGSize
}
