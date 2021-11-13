//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        Button(action: {
            transactionViewModel.action(transactionViewModel.transaction)
        }) {
        VStack {
            HStack {
                Text(transactionViewModel.transaction.category.rawValue)
                    .font(.headline)
                    .foregroundColor(transactionViewModel.transaction.category.color)
                Spacer()
                if !transactionViewModel.pinned {
                    Image(systemName: "pin.fill")
                } else {
                    Image(systemName: "pin.slash.fill")
                }
            }
            if !transactionViewModel.pinned {
                HStack {
                    transactionViewModel.transaction.image
                        .resizable()
                        .frame(
                            width: 60.0,
                            height: 60.0,
                            alignment: .top
                        )
                    
                    VStack(alignment: .leading) {
                        Text(transactionViewModel.transaction.name)
                            .secondary()
                        Text(transactionViewModel.transaction.accountName)
                            .tertiary()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("$\(transactionViewModel.transaction.amount.formatted())")
                            .bold()
                            .secondary()
                        Text(transactionViewModel.transaction.date.formatted)
                            .tertiary()
                    }
                }
            }
        }
        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            TransactionView(transactionViewModel: TransactionViewModel(pinned: false, transaction: ModelData.sampleTransactions[0], action: { print($0)
            }))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
