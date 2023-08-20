//
//  RestaurantsView.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import SwiftUI
import Dependencies
import DataModels
import DesignSystem

public struct RestaurantsView: View {
    @StateObject var viewModel: RestaurantsViewModel
    
    public init(viewModel: RestaurantsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(viewModel.filterItems) { filterItem in
                        Button(
                            action: {
                                withAnimation {
                                    viewModel.prepareFilteredData(byFilterId: filterItem.id)
                                }
                            },
                            label: {
                                FilterItemView(filterItem)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 60)
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.restaurants) { restaurant in
                    if restaurant.visible {
                        RestaurantItemView(restaurant: restaurant)
                            .onTapGesture {
                                viewModel.selectedResturant = restaurant
                            }
                    }
                }
            }
            .scenePadding(.horizontal)
        }
        .sheet(
            item: $viewModel.selectedResturant,
            content: { restaurant in
                DetailView(
                    viewModel: withDependencies(
                        from: viewModel,
                        operation: { DetailViewModel(restaurant: restaurant) }
                    )
                )
            }
        )
        .frame(maxWidth: .infinity)
        .task {
            await viewModel.fetchRestaurants()
        }
        .background(Color.DesignSystem.background)
        .scenePadding(.top)
    }
    
    @ViewBuilder
    func FilterItemView(_ filterItem: FilterModel) -> some View {
        HStack {
            AsyncImage(
                url: filterItem.imageUrl,
                content: { image in
                    image.resizable()
                },
                placeholder: {
                    ProgressView()
                }
            )
            .frame(width: 48, height: 48)
            .cornerRadius(24)
            Text(filterItem.name)
                .font(.DesignSystem.title2)
                .frame(maxWidth: .infinity)
                .padding(.trailing, 16)
        }
        .frame(minWidth: 144)
        .frame(height: 48)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(filterItem.selected ? Color.DesignSystem.selected : Color.white)
        )
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.16), radius: 2)
    }
    
    @ViewBuilder
    func RestaurantItemView(restaurant: RestaurantModel) -> some View {
        Color.white
            .frame(height: 196)
            .roundedCorner(12, corners: [.topLeft, .topRight])
            .shadow(color: Color.black.opacity(0.20), radius: 4)
            .overlay {
                VStack(spacing: 8) {
                    AsyncImage(
                        url: restaurant.imageURL,
                        content: { image in
                            image
                                .resizable()
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(height: 132)
                    .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                    HStack {
                        VStack(alignment: .leading) {
                            Text(restaurant.name)
                                .font(.DesignSystem.title1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(restaurant.tags.joined(separator: ", "))
                                .font(.DesignSystem.subtitle1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.DesignSystem.subtitle)
                            Spacer()
                            HStack {
                                Image.DesignSystem.clockIcon
                                Text(restaurant.deliveryTimeMinutes.description + " mins")
                                    .font(.DesignSystem.footer1)
                            }
                        }
                        .overlay(alignment: .topTrailing) {
                            HStack {
                                Image.DesignSystem.starIcon
                                Text(restaurant.rating.description)
                                    .font(.DesignSystem.footer1)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    
                }
                .padding(.bottom, 4)
            }
    }
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView(
            viewModel: withDependencies({
                $0.restaurantClient = .previewValue
            }, operation: {
                RestaurantsViewModel()
            })
        )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
