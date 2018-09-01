//
//  UIViewController+MemoryLeakChecker.swift
//  LeakCheckDemo
//
//  Created by corin8823 on 2018/08/25.
//  Copyright © 2018年 corin8823. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc private func executeCheckLeak(_ animated: Bool) {
        self.executeCheckLeak(animated)
        self.checkLeak()
    }

    static func enableMemoryLeakChecker() {
        if let fromMethod = class_getInstanceMethod(UIViewController.self, #selector(viewDidDisappear(_:))),
            let toMethod = class_getInstanceMethod(UIViewController.self, #selector(executeCheckLeak(_:))) {
            method_exchangeImplementations(fromMethod, toMethod)
        }
    }
}

private extension UIViewController {

    func checkLeak(afterDelay delay: TimeInterval = 1.5) {
        if isMovingFromParentViewController || rootParentViewController.isBeingDismissed {
            let reason = isMovingFromParentViewController ? "removed from its parent" : "dismissed"
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                if let wself = self {
                    #if DEBUG
                        print("🚰 \(String(describing: wself)) not deallocated after being \(reason)")
                    #endif
                }
            }
        }
    }

    var rootParentViewController: UIViewController {
        var root = self
        while let parent = root.parent {
            root = parent
        }
        return root
    }
}
