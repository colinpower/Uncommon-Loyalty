////
////  ItemsAndOrders.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 8/26/22.
////
//

//MARK: NOTE, BRING THIS TO THE FIRST PAGE "FOR YOU TODAY"

import SwiftUI

struct ItemsAndOrders: View {

    @ObservedObject var itemsViewModel = ItemsViewModel()

    @EnvironmentObject var viewModel: AppViewModel

    //@Binding var selectedTab: Int

    let data = (1...100).map { "Item \($0)" }

    let gridItems = [
        GridItem(.fixed(UIScreen.main.bounds.width/2), spacing: 0),
        GridItem(.fixed(UIScreen.main.bounds.width/2), spacing: 0)
//        GridItem(.fixed(100)),
//        GridItem(.fixed(100))
    ]

    var body: some View {

        ZStack(alignment: .bottom) {
            VStack {
                Text("Items and Orders").font(.largeTitle)

                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 0) {
                        ForEach(itemsViewModel.myItems) { item1 in
                            //SmallItemReviewAndReferWidget(item: item1)
                            VStack {
                                HStack(spacing: 6) {
                                    Spacer()
                                    Image(systemName: "star")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color("ReviewTeal"))
                                    Image(systemName: "star")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color("ReviewTeal"))
                                }.padding([.trailing, .vertical], 6)
                                Image("redshorts")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                VStack {
                                    Text(item1.title)
                                    Text(item1.price)
                                }.frame(height: CGFloat(40))
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width/2, height: CGFloat(40))

                            }.frame(height: UIScreen.main.bounds.height/3)
                            .overlay(
                                Rectangle()
                                    .stroke(Color(.gray), lineWidth: 3)
                            )
                        }
                    }
                }.frame(width: UIScreen.main.bounds.width)
            }

        }.onAppear {
            self.itemsViewModel.listenForMyItems(email: viewModel.email ?? "colinjpower1@gmail.com")
        }
    }




}
//
//struct ItemsAndOrders_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsAndOrders()//selectedTab: .constant(1))
//    }
//}
//
