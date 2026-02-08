//
//  AuthPresentationHelper.swift
//  CookFlow
//
//  Created by Codex on 2/3/26.
//

import UIKit

@MainActor
enum AuthPresentationHelper {
    static func keyWindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    static func topViewController() -> UIViewController? {
        guard let root = keyWindow()?.rootViewController else {
            return nil
        }
        return topViewController(from: root)
    }

    private static func topViewController(from controller: UIViewController) -> UIViewController {
        if let presented = controller.presentedViewController {
            return topViewController(from: presented)
        }
        if let navigation = controller as? UINavigationController,
           let visible = navigation.visibleViewController {
            return topViewController(from: visible)
        }
        if let tab = controller as? UITabBarController,
           let selected = tab.selectedViewController {
            return topViewController(from: selected)
        }
        return controller
    }
}
