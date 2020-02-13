//
//  AppDelegate.swift
//  MVC
//
//  Created by Hyeon su Ha on 12/02/2020.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit
@_exported import AsyncDisplayKit
@_exported import TextureSwiftSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  public var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.makeKeyAndVisible()
    
    let rootViewContoller = CardViewController()
    rootViewContoller.coordinateController?.dataStore?.cardID = 1
    self.window?.rootViewController = UINavigationController(rootViewController: rootViewContoller)
    
    return true
  }

}

