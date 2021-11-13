import SwiftUI

class PinnedService: ObservableObject {
    
    fileprivate static let shared = PinnedService()
    @Published var pinnedTransactions: Set<TransactionModel> = Set<TransactionModel>()
    
}

struct PinnedServiceKey: EnvironmentKey {
    static var defaultValue: PinnedService {
        return PinnedService.shared
    }
}

extension EnvironmentValues {
    var pinned: PinnedService {
        get { return self[PinnedServiceKey.self]  }
        set { self[PinnedServiceKey.self] = newValue }
    }
    
}
