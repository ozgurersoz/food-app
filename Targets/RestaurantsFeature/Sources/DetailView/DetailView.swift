//
//  DetailView.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import SwiftUI
import Dependencies
import DataModels
import DesignSystem

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    public init(viewModel: DetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                AsyncImage(
                    url: viewModel.restaurant.imageURL,
                    content: { image in
                        image.resizable()
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                Color.white
                    .frame(height: 84)
            }
            .overlay(alignment: .bottom) {
                VStack {
                    Color.white
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .frame(height: 144)
                        .overlay {
                            VStack{
                                Spacer()

                                Text(viewModel.restaurant.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.DesignSystem.title1)
                                Spacer()
                                Text(viewModel.restaurant.tags.joined(separator: ","))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.DesignSystem.headline2)
                                    .foregroundColor(.DesignSystem.subtitle)
                                Spacer()
                                if let restaurantStatus = viewModel.restaurantStatus {
                                    Text(restaurantStatus.isOpen ? "Open" : "Closed")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.DesignSystem.title1)
                                        .foregroundColor(restaurantStatus.isOpen ? .DesignSystem.positive : .DesignSystem.negative)
                                    Spacer()
                                }

                            }
                            .padding(.horizontal, 12)

                        }
                }
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text(viewModel.presentedError?.reason ?? ""),
                dismissButton: .default(Text("OK")) {
                    viewModel.presentedError = nil
                }
            )
        }
        .task {
            await viewModel.fetchRestaurantStatus()
        }
    }
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
    static var randomRestaurant = MockData.restaurants.first!
    
    static var previews: some View {
        DetailView(
            viewModel: withDependencies({ _ in
                MockData.restaurants.addTags(from: MockData.filterItems)
            }, operation: {
                DetailViewModel(restaurant: randomRestaurant)
            })
        )
    }
}
#endif
