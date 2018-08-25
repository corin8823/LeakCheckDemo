//
//  AppDelegate.swift
//  LeakCheckDemo
//
//  Created by corin8823 on 2018/08/25.
//  Copyright © 2018年 corin8823. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
            UIViewController.enableMemoryLeakChecker()
        #endif

        return true
    }
}
