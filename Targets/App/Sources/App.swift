import SwiftUI
import RestaurantsFeature
import Dependencies

class AppModel: ObservableObject {
    @Dependency(\.restaurantClient) var restaurantClient
}

@main
struct iRestApp: App {
    @StateObject var appModel = AppModel()
    
    var body: some Scene {
        WindowGroup {
            RestaurantsView(
                viewModel: withDependencies(
                    from: appModel,
                    operation: { RestaurantsViewModel() }
                )
            )
        }
    }
}

