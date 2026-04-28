import SwiftUI

struct PaywallView: View {

    @StateObject private var vm = PaywallViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                 heroImage
                    .padding(.top, -60)

                contentCard
                    .padding(.top, -50)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    //
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.dimming.opacity(0.42))
                }
                .padding(.trailing, 16)
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .overlay {
            if vm.purchaseState == .loading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .allowsHitTesting(true)
            }
        }
        .alert(item: $vm.alertItem) { item in
            Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - Helpers
    private var buttonBackground: Color {
        switch vm.purchaseState {
        case .idle:    return Color.accent
        case .loading: return Color.accent.opacity(0.7)
        default: return Color.accent
        }
    }
}

#Preview {
    PaywallView()
}

extension PaywallView {
    private var heroImage: some View {
        Image("lego")
                .resizable()
                .blendMode(.darken)
                .frame(maxHeight: 294)
    }
    
    private var contentCard: some View {
        VStack(spacing: 0) {
            VStack(spacing: 6) {
                Text("Premium Bricks")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.title)

                Text("A curated crate of LEGO pieces, delivered\nto your door every month.")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)

            // Features list
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Feature.all) { feature in
                    FeatureRowView(feature: feature)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)

            // Plan cards
            VStack(spacing: 10) {
                ForEach(SubscriptionPlan.allCases) { plan in
                    PlanCardView(
                        plan: plan,
                        isSelected: vm.selectedPlan == plan
                    ) {
                        vm.selectedPlan = plan
                    }
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)

            // CTA Button
            Button {
                vm.purchase()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(buttonBackground)

                    if vm.purchaseState == .loading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(vm.ctaTitle)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 54)
            }
            .disabled(vm.isButtonDisabled)
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .animation(.easeInOut(duration: 0.2), value: vm.purchaseState)

            // Legal disclaimer
            Text("Auto-renews at the price above until canceled in Settings\nCancel at least 24h before renewal.")
                .minimumScaleFactor(0.5)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.horizontal, 24)

            // Footer links
            HStack(spacing: 0) {
                Spacer()

                Button("Restore Purchases") { vm.restorePurchases() }
                Spacer()
                Button("Terms of Use") { vm.openTermsOfUse() }
                Spacer()
                Button("Privacy Policy") { vm.openPrivacyPolicy() }

                Spacer()
            }
            .font(.system(size: 13))
            .foregroundColor(.accent)
            .padding(.top, 12)
            .padding(.bottom, 32)
        }
    }
}
