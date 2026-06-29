import SwiftUI

struct TitleDetailsView: View {
    let titleId: String

    var body: some View {
        PlaceholderFeatureView(title: "Тайтл", subtitle: "ID: \(titleId)")
    }
}
