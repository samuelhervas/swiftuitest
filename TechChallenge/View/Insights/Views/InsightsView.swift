//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    
    @ObservedObject var insightsViewModel: InsightsViewModel
    
    var body: some View {
        List {
            RingView(viewModel: insightsViewModel)
                .scaledToFit()
            
            ForEach(insightsViewModel.categoriesInsightsViewModel) { category in
                HStack {
                    Text(category.categoryName)
                        .font(.headline)
                        .foregroundColor(category.categoryColor)
                    Spacer()
                    Text("$\(category.amount.formatted())")
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(insightsViewModel: InsightsViewModel())
            .previewLayout(.sizeThatFits)
    }
}
#endif
