//
//  AppDelegate.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 06/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AppCoordinator?
    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MuseuZap")
        container.loadPersistentStores(completionHandler: { (_, error) in //storeDescription, error
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // FatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Initialise the first coordinator with the main navigation controller
        coordinator = AppCoordinator(rootViewController: navController)
        coordinator?.startFlow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

//        addTestDataTesteEntity()

        return true
    }

//    func addTestDataTesteEntity() {
//        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
//        // Get entity, then generatehow  an object from it
//        guard let entity = NSEntityDescription.entity(forEntityName: "Teste", in: context)
//        else {
//            fatalError("Could not find entity")
//        }
//
//        for i in 1...3 {
//            let teste = Teste(entity: entity, insertInto: context)
//
//            teste.titulo = "titulo \(i)"
//            teste.subtitulo = "subtitulo \(i)"
//        }
//    }

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
