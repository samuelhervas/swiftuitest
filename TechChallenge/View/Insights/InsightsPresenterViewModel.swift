import Combine
import SwiftUI

class CategoriesInsightsViewModel: ObservableObject {
    
    private var category: TransactionModel.Category
    
    var ratio: Float
    var amount: Double
    var offset: Float
    
    var categoryName: String {
        category.rawValue
    }
    var categoryColor: Color {
        category.color
    }
    
    init(category: TransactionModel.Category,
         ratio: Float,
         amount: Double,
         offset: Float) {
        self.category = category
        self.ratio = ratio
        self.amount = amount
        self.offset = offset
    }
}

extension CategoriesInsightsViewModel: Identifiable {
    
    var id: String {
        return category.id
    }
}

class InsightsViewModel: ObservableObject {
    
    private var publisher: AnyCancellable? = nil
    @DistinctEnvironmentObject(\.pinned) var pinnedService: PinnedService
    var categoriesInsightsViewModel: [CategoriesInsightsViewModel] = []
    
    private func updateViewModel(categories: [TransactionModel.Category] = TransactionModel.Category.allCases,
                                 transactions: [TransactionModel] = ModelData.sampleTransactions,
                                 pinned: Set<TransactionModel> = Set<TransactionModel>()) -> [CategoriesInsightsViewModel] {
        let pinnedTransactions = transactions.filter { !pinned.contains($0) }
        let totalAmount = pinnedTransactions.amount()
        var offset: Float = 0
        return categories.compactMap { category -> CategoriesInsightsViewModel in
            let filteredTransactions = pinnedTransactions.filter { $0.category == category }
            let amount = filteredTransactions.amount()
            let ratio = Float(amount)/Float(totalAmount)
            let viewModel = CategoriesInsightsViewModel(category: category, ratio: ratio, amount: amount, offset: offset)
            offset += ratio
            return viewModel
        }
    }
    
    init(categories: [TransactionModel.Category] = TransactionModel.Category.allCases,
         transactions: [TransactionModel] = ModelData.sampleTransactions) {
        categoriesInsightsViewModel = updateViewModel()
        publisher = pinnedService.$pinnedTransactions.sink { pinned in
            self.categoriesInsightsViewModel = self.updateViewModel(pinned: pinned)
        }
    }
}

@propertyWrapper
struct DistinctEnvironmentObject<Wrapped>: DynamicProperty where Wrapped : ObservableObject {
    
    var wrappedValue: Wrapped {
        _wrapped
    }
    
    @ObservedObject private var _wrapped: Wrapped
    
    init(_ keypath: KeyPath<EnvironmentValues, Wrapped>) {
        _wrapped = Environment<Wrapped>(keypath).wrappedValue
    }
}
