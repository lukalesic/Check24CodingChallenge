//
//  ProductListMainView.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import SwiftUI

struct ProductListMainView: View {
    @EnvironmentObject private var viewModel: ProductListViewModel
    @State private var isPresentingWebLink = false
    
    //Animation triggers
    @State private var isAnimatingFavourite = false
    
    var body: some View {
        NavigationStack {
            switch viewModel.dataState {
            case .empty:
                Color.clear
            case .loading:
                ProgressView()
            case .error(let error):
                errorView(error: error)
            case .populated:
                pickerView()
                homeScreen()
                    .navigationTitle("Check24 Demo App")
                    .navigationBarTitleDisplayMode(.inline)
                    .onChange(of: viewModel.selectedFilter) { _, _ in
                        viewModel.categorizeProducts()
                    }
                    .sheet(isPresented: $isPresentingWebLink) {
                        FooterWebpageView(isPresentingWebLink: $isPresentingWebLink)
                    }
            }
        }
        .animation(.spring, value: viewModel.didUpdateState)
    }
}

private extension ProductListMainView {
    
    @ViewBuilder
    func pickerView() -> some View {
        Picker("Choose a filter!", selection: $viewModel.selectedFilter) {
            ForEach(SelectedFilter.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func homeScreen() -> some View {
        VStack(alignment: .leading) {
            if(viewModel.selectedFilter == .favourites && viewModel.filteredProducts.count == 0) {
                noFavouritesAvailableView()
            }
            else {
                productsList()
            }
        }
    }
    
    @ViewBuilder
    func noFavouritesAvailableView() -> some View {
        ContentUnavailableView("No favourites added!", systemImage: "star.fill")
    }
    
    @ViewBuilder
    func productsList() -> some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 3) {
                    listTitle()
                    listSubtititle()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            
            ForEach(viewModel.filteredProducts) { productVM in
                ZStack {
                    SingleProductView(productVM)
                        .swipeActions {
                            Button(productVM.isFavourite() ? "Vergessen" : "Vormerken") {
                                productVM.toggleFavouriteState()
                                isAnimatingFavourite.toggle()
                            }
                        }
                        .tint(productVM.isFavourite() ? .red : .orange)
                    
                    NavigationLink(destination: ProductDetailView(productViewModel: productVM)) {
                        EmptyView()
                    }
                    .frame(width: 0)
                    .opacity(0)
                }
                .listRowBackground(productVM.isFavourite() ? Color.favouritesColor.opacity(0.5) : nil)
            }
            Group {
                footerTextView()
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
        .listSectionSpacing(8)
        .contentMargins(.vertical, 8)

        .animation(.default, value: viewModel.selectedFilter)
        .refreshable {
            Task {
                await viewModel.handleRefresh()
            }
        }
    }
    
    @ViewBuilder
    func listTitle() -> some View {
        Text(viewModel.headerTitle)
            .font(.headline)
    }
    
    @ViewBuilder
    func listSubtititle() -> some View {
        Text(viewModel.headerSubtitle)
            .font(.subheadline)
    }
    
    @ViewBuilder
    func footerTextView() -> some View {
        FooterTextView(isPresentingWebLink: $isPresentingWebLink)
    }
        
    @ViewBuilder
    func errorView(error: Error) -> some View {
        VStack {
            ContentUnavailableView(error.localizedDescription, systemImage: "exclamationmark.triangle")
            
            Button {
                Task {
                    await viewModel.handleRefresh()
                }
            } label: {
                Text("Tap to reload")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, -100)
            Spacer()
        }
    }
}
