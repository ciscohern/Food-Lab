//
//  AppDelegate.swift
//  FoodLab
//
//  Created by Francisco Hernanedez on 3/13/18.
//  Copyright © 2018 Francisco Hernanedez. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {
            FirebaseApp.configure()
            
            FBSDKApplicationDelegate.sharedInstance().application(application,didFinishLaunchingWithOptions:launchOptions)
            
            
            return true
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject)-> Bool{
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    
    
} 
