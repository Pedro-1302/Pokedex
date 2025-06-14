import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let rootViewController = createRootNavigationController()
        setupWindow(with: rootViewController, on: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

extension SceneDelegate {
    private func createRootNavigationController() -> UINavigationController {
        let pokemonListVC = PokemonListVC()
        return UINavigationController(rootViewController: pokemonListVC)
    }

    private func setupWindow(with rootViewController: UIViewController, on windowScene: UIWindowScene) {
        let mainWindow = UIWindow(windowScene: windowScene)
        mainWindow.rootViewController = rootViewController
        mainWindow.makeKeyAndVisible()
        self.window = mainWindow
    }
}
