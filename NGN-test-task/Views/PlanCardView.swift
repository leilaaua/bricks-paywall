import SwiftUI

struct PlanCardView: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button {
        onSelect()
        
    } label: {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .strokeBorder(
                            isSelected ? Color.accent : Color(.checkMark),
                            lineWidth: 2
                        )
                        .frame(width: 20, height: 20)

                    if isSelected {
                        Circle()
                            .fill(Color.accent)
                            .frame(width: 20, height: 20)
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)

                // Labels
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(plan.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)

                        if plan.isBestValue {
                            Text("BEST VALUE")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 3)
                                .background(Capsule().fill(Color.green))
                        }
                    }

                    Text(plan.subtitle)
                        .font(.system(size: 13))
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // Price
                Text(plan.price)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(
                                isSelected ? Color.accent : Color(.clear),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: isSelected)
    }
}

#Preview {
    VStack(spacing: 12) {
        PlanCardView(plan: .yearly, isSelected: false, onSelect: {})
        PlanCardView(plan: .monthly, isSelected: true, onSelect: {})
    }
    .padding()
}
