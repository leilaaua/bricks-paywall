import Foundation

enum SubscriptionPlan: String, CaseIterable, Identifiable {
    case yearly
    case monthly

    var id: String { rawValue }

    var title: String {
        switch self {
        case .yearly:  return "Yearly"
        case .monthly: return "Monthly"
        }
    }

    var price: String {
        switch self {
        case .yearly:  return "$129.99"
        case .monthly: return "$14.99"
        }
    }

    var subtitle: String {
        switch self {
        case .yearly:  return "$10.83 / month  |  Save 30%"
        case .monthly: return "7-day free trial, then billed monthly"
        }
    }

    var isBestValue: Bool { self == .yearly }

    /// CTA button title depends on selected plan
    var ctaTitle: String {
        switch self {
        case .monthly: return "Start Free Trial"
        case .yearly:  return "Continue"
        }
    }
}
