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

@UIApplicationMain
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

//        addTestData()
        addCategory()

        // Print appGroup contents
//        print(FileExchanger().listAllFilesInApplicationGroupFolder())

        return true
    }

    // MARK: - SET UP

    func setNavigationBarColor() {
        UINavigationBar.appearance().backgroundColor = UIColor.Default.navBar
        UINavigationBar.appearance().barTintColor = UIColor.Default.navBar
        UINavigationBar.appearance().isTranslucent = false
    }

    private func addCategory() {
        let category = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category.categoryName = "Debuggando"

        AudioCategoryServices().createCategory(category: category) { (error) in
            if let err = error {
                print(err as Any)
            }
        }
    }
    
    private func addTestData() {
        let context = CoreDataManager.sharedInstance.managedObjectContext
        // Get entity, then generatehow  an object from it
        guard let entity1 = NSEntityDescription.entity(forEntityName: Entities.audio.rawValue, in: context),
              let entity2 = NSEntityDescription.entity(forEntityName: Entities.audioCategory.rawValue, in: context)
        else {
            fatalError("Could not find entities")
        }

        for i in 1...3 {
            let audio = Audio(entity: entity1, insertInto: context)
            let category = AudioCategory(entity: entity2, insertInto: context)

            category.categoryName = "Categoria \(i)"

            audio.audioName = "Audio v.\(i)"
            audio.audioPath = "/Documents/MuseuZap/Audio\(i)"
            audio.isPrivate = true
            audio.duration = 5.44

            category.addToAudios(audio)
            AudioCategoryServices().createCategory(category: category) { (error) in
                if let err = error {
                    print(err as Any)
                }
            }
        }

        // Save context once
//        do {
//            try CoreDataManager.sharedInstance.managedObjectContext.save()
//        } catch {
//            print("COULD NOT SAVE CONTEXT")
//        }
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
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
           // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       }

       func applicationWillTerminate(_ application: UIApplication) {
           // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       }
}
