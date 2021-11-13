import Foundation

final class TransactionViewModel: ObservableObject {
   
    @Published var pinned: Bool
    let transaction: TransactionModel
    let action: (TransactionModel)-> Void
    
    init(pinned: Bool,
         transaction: TransactionModel,
         action: @escaping (TransactionModel)-> Void) {
        self.pinned = pinned
        self.transaction = transaction
        self.action = action
    }
}

extension TransactionViewModel: Identifiable {
    
    var id: Int {
        return transaction.id
    }

}

final class TransactionListViewModel: ObservableObject {
    
    let pills: [Pill]
    @Published var transactions: [TransactionViewModel]
    @Published var prices: Double
    @Published var selected: TransactionModel.Category?
    
    var didSelected: (TransactionModel.Category?)-> Void
    
    init(pills: [Pill],
         transactions: [TransactionViewModel],
         selected: TransactionModel.Category?,
         prices: Double,
         didSelected: @escaping (TransactionModel.Category?)-> Void) {
        self.pills = pills
        self.transactions = transactions
        self.prices = prices
        self.selected = selected
        self.didSelected = didSelected
    }
    
}
