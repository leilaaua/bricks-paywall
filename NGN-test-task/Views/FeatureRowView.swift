import SwiftUI

struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
}

extension Feature {
    static let all: [Feature] = [
        Feature(
            icon: "ic_pieces",
            title: "500+ curated pieces",
            subtitle: "Hand-picked for each build set"
        ),
        Feature(
            icon: "ic_shipping",
            title: "Free shipping, monthly",
            subtitle: "New crate at your door every month"
        ),
        Feature(
            icon: "ic_guides",
            title: "Exclusive build guides",
            subtitle: "Step-by-step in the companion app"
        ),
        Feature(
            icon: "ic_cancel",
            title: "Cancel anytime",
            subtitle: "No questions, no fees"
        ),
    ]
}

struct FeatureRowView: View {
    let feature: Feature

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accent.opacity(0.10))
                    .frame(width: 40, height: 40)
                Image(feature.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(feature.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text(feature.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
        }
    }
}
