//
//  ProductListViewModel.swift
//  Check24CodingChallenge
//
//  Created by Luka Lešić on 20.02.2024..
//

import Foundation
import Combine

@MainActor
class ProductListViewModel: ObservableObject {
    @Published var products: [ProductViewModel] = []
    @Published var filteredProducts: [ProductViewModel] = []
    @Published var headerTitle: String = ""
    @Published var headerSubtitle: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedFilter: SelectedFilter = .all
    
    //didUpdateState is used to trigger state-change animations in the View
    @Published private(set) var didUpdateState = false
    
    @Published private(set) var dataState: DataState = .empty {
        didSet {
            didUpdateState.toggle()
        }
    }
    
    private let networkFetcher = NetworkFetcher()
    
    init() {
        setupFavouritesObserver()
        Task {
            await getProducts()
        }
    }
    
    //MARK: setting up Combine
    
    private func setupFavouritesObserver() {
        FavouritesManager.shared.$favourites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favourites in
                guard let self = self else { return }
                self.filterFavourites()
                self.refreshListProductColors()
            }
            .store(in: &cancellables)
    }
    
    //MARK: Getting and assigning data from Network Fetcher class
    
    private func getProducts() async {
        do {
            dataState = .loading
            
            resetProductList()
                        
            let productsURL = networkFetcher
                .createURL(for: APIEndpoint.products,
                           path: APIEndpoint.products.path)
            
            let response: BaseResponse = try await networkFetcher
                .fetchData(from: productsURL)
            
            let products: [Product] = response.products
            
            self.headerTitle = response.header.headerTitle
            self.headerSubtitle = response.header.headerDescription
            
            mapToViewModels(products: products)
            categorizeProducts()
            
            if products.count > 0 {
                dataState = .populated
            }
        } catch {
            dataState = .error(error: error)
            print(error)
        }
    }
    
    private func mapToViewModels(products: [Product]) {
        self.products = products.map { p in
            let productVM = ProductViewModel(product: p)
            return productVM
        }
    }
    
    //MARK: categorising based on filters
    
    func categorizeProducts() {
        guard products.count > 0 else { return }
        
        switch selectedFilter {
        case .all:
            displayAllAvailableProducts()
        case .favourites:
            filterFavourites()
        case .available:
            filterAvailableProducts()
        }
    }
    
    private func displayAllAvailableProducts() {
        self.filteredProducts = products
    }
    
    private func filterFavourites() {
        guard selectedFilter == .favourites else { return }
        
        let favourites = products.filter { productVM in
            let isFavourite = FavouritesManager
                .shared
                .contains(productVM.id) == true
            return isFavourite
        }
        
        filteredProducts = favourites
    }
    
    private func filterAvailableProducts() {
        guard selectedFilter == .available else { return }

        let availableProducts = products.filter({ $0.isAvailable })
        filteredProducts = availableProducts
    }
    
    //TODO: refactor
    private func refreshListProductColors() {
        self.filteredProducts = filteredProducts
    }
    
    //TODO: refactor
    func handleRefresh() async {
        dataState = .loading
        resetProductList()
        await getProducts()
    }
    
    private func resetProductList() {
        products = []
        filteredProducts = []
    }
}
