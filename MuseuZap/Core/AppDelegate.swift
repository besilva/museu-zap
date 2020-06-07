//
//  AppDelegate.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData
import DatabaseKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AppCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabController =  TabBar()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Initialise the first coordinator with the main navigation controller
        coordinator = AppCoordinator(rootViewController: tabController)
        coordinator?.startFlow()
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        setNavigationBarColor()
        setStatusBarColor()
        
        // Audio Controls
        AudioManager.shared.configureAVAudioSession()
        AudioManager.shared.setupRemoteTransportControls()
        application.beginReceivingRemoteControlEvents()
        
        // Firebase
        FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
        FirebaseApp.configure()
        
        // Add a default category and default audio, only once per user Defaults
        if UserDefaults.standard.object(forKey: "isFirstTime") == nil {
            UserDefaults.standard.set(false, forKey: "isFirstTime")
            addPrivateCategories()
            addPublicCategories()
        }
        
        // Every time the application launches, change the main Bundle URL, so public audios are not saved
        addPublicAudio()

        return true
    }
    
    // MARK: - SET UP
    
    func setNavigationBarColor() {
        UINavigationBar.appearance().backgroundColor = UIColor.Default.navBar
        UINavigationBar.appearance().barTintColor = UIColor.Default.navBar
        UINavigationBar.appearance().isTranslucent = false
    }

    func setStatusBarColor() {
        if #available(iOS 13, *) {
             let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
             statusBar.backgroundColor = UIColor.Default.navBar
             UIApplication.shared.keyWindow?.addSubview(statusBar)
         } else {
            // ADD THE STATUS BAR AND SET A CUSTOM COLOR
            // swiftlint:disable force_cast
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
               statusBar.backgroundColor = UIColor.Default.navBar
            }
            // swiftlint:enable force_cast
         }
    }

    private func addPublicAudio() {
        var categoryArray = [AudioCategory]()
        AudioCategoryServices().getAllCategoriesWith(isPrivate: false) { (error, array) in
            if let categories = array {
               categoryArray = categories
            } else {
                print(error ?? "addPublicAudio error\n")
            }
        }

        let category = categoryArray[0]

        // All public audios
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) else { return }

        for url in urls {
            let name = url.deletingPathExtension().lastPathComponent

            let publicAudio = Audio(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
            publicAudio.audioName = name
            publicAudio.audioPath = url.path
            publicAudio.duration = AudioManager.shared.getDurationFrom(file: url)
            publicAudio.isPrivate = false
            publicAudio.category = category
        }
    }

    private func addPrivateCategories() {
        let category1 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category1.categoryName = "Humor"
        category1.assetIdentifier = "funny-private"
        category1.isPrivate = true

        let category2 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category2.categoryName = "Familia"
        category2.assetIdentifier = "family-private"
        category2.isPrivate = true
        
        let category3 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category3.categoryName = "Trabalho"
        category3.assetIdentifier = "work-private"
        category3.isPrivate = true
        
        let category4 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category4.categoryName = "Estudos"
        category4.assetIdentifier = "study-private"
        category4.isPrivate = true
        
        let category5 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category5.categoryName = "Sem Categoria"
        category5.isPrivate = true
        
        AudioCategoryServices().createCategory(category: category1) { _ in }
        AudioCategoryServices().createCategory(category: category2) { _ in }
        AudioCategoryServices().createCategory(category: category3) { _ in }
        AudioCategoryServices().createCategory(category: category4) { _ in }
        AudioCategoryServices().createCategory(category: category5) { _ in }
    }
    
    func addPublicCategories() {
        let category1 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category1.categoryName = "Engraçados"
        category1.assetIdentifier = "funny"
        category1.isPrivate = false
        
        let category2 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
               category2.categoryName = "Clássicos do Zap"
               category2.assetIdentifier = "classic"
               category2.isPrivate = false
        
        AudioCategoryServices().createCategory(category: category1) { _ in }
        AudioCategoryServices().createCategory(category: category2) { _ in }
    }
    
    // MARK: - Default App Delegate
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if let tabBar = (window?.rootViewController as? TabBar) {
            if let navigation = tabBar.currentViewController as? UINavigationController {
                if let listViewController = navigation.topViewController as? ListViewController {
                    listViewController.retrieveAllAudios()
                }
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
