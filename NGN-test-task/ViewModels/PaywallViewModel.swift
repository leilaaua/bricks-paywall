import SwiftUI
import Combine

enum PurchaseState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}

@MainActor
final class PaywallViewModel: ObservableObject {

    @Published var selectedPlan: SubscriptionPlan = .monthly
    @Published var purchaseState: PurchaseState = .idle
    @Published var alertItem: AlertItem?

    struct AlertItem: Identifiable {
        let id = UUID()
        let title: String
        let message: String
    }

    // MARK: - Purchase stub
    func purchase() {
        guard purchaseState == .idle else { return }
        purchaseState = .loading

        Task {
            try? await Task.sleep(for: .milliseconds(1500))

            // Simulate 80 % success
            if Bool.random() || Bool.random() {
                purchaseState = .success
                alertItem = AlertItem(
                    title: "Welcome!",
                    message: "Your \(selectedPlan.title) subscription is now active."
                )
            } else {
                let msg = "Payment declined. Please check your payment method and try again."
                purchaseState = .error(msg)
                alertItem = AlertItem(title: "Purchase Failed", message: msg)
            }

            try? await Task.sleep(for: .seconds(2))
            purchaseState = .idle
        }
    }

    // MARK: - Restore stub
    func restorePurchases() {
        purchaseState = .loading
        Task {
            try? await Task.sleep(for: .milliseconds(1200))
            purchaseState = .idle
            alertItem = AlertItem(
                title: "Restore Complete",
                message: "No previous purchases found for this Apple ID."
            )
        }
    }

    // MARK: - Legal stubs
    func openPrivacyPolicy() {
        guard let url = URL(string: "https://www.apple.com/legal/privacy/") else { return }
        UIApplication.shared.open(url)
    }

    func openTermsOfUse() {
        guard let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/") else { return }
        UIApplication.shared.open(url)
    }

    // MARK: - Computed helpers
    var ctaTitle: String {
        selectedPlan.ctaTitle
    }

    var isButtonDisabled: Bool {
        purchaseState == .loading || purchaseState == .success
    }
}
