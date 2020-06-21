//
//  AppDelegate.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 28/01/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
//import FirebaseAuth
import FirebaseCrashlytics
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        
        FirebaseApp.configure()
        
        ///Google Set clientID
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        
        ///Facebook
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        return true
    }
    
    ///Facebook - Google mandatory Method
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        return GIDSignIn.sharedInstance().handle(url)
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        let realm = try! Realm()
        let allUploadingObjects = realm.objects(Item.self)
        
        try! realm.write {
            realm.delete(allUploadingObjects)
        }
        
    }
        
    /*
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
    }
    */
    
}
