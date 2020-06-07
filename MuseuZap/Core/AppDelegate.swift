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

        // All public audios
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) else { return }

        let funnyAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return funny.contains(name)
        }

        let classicAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return classic.contains(name)
        }

        let jokesAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return jokes.contains(name)
        }

        let musicalAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return musical.contains(name)
        }

        let fridayAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return friday.contains(name)
        }

        let answerAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return answer.contains(name)
        }

        let familyAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return family.contains(name)
        }

        let pranksAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return pranks.contains(name)
        }

        let quarantineAudios = urls.filter { (url) -> Bool in
            let name = url.deletingPathExtension().lastPathComponent
            return quarantine.contains(name)
        }

        // Loop through array and add audio to its correnponding category
        for category in categoryArray {
            switch category.assetIdentifier {
            case "funny":
                addCategoryToAudios(audios: funnyAudios, withCategory: category)
            case "classic":
                addCategoryToAudios(audios: classicAudios, withCategory: category)
            case "jokes":
                addCategoryToAudios(audios: jokesAudios, withCategory: category)
            case "musical":
                addCategoryToAudios(audios: musicalAudios, withCategory: category)
            case "friday":
                addCategoryToAudios(audios: fridayAudios, withCategory: category)
            case "answer":
                addCategoryToAudios(audios: answerAudios, withCategory: category)
            case "family":
                addCategoryToAudios(audios: familyAudios, withCategory: category)
            case "pranks":
                addCategoryToAudios(audios: pranksAudios, withCategory: category)
            case "quarantine":
                addCategoryToAudios(audios: quarantineAudios, withCategory: category)
            default:
                print()
            }
        }
    }

    private func addPrivateCategories() {
        let category1 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category1.categoryName = "Humor"
        category1.assetIdentifier = "funny"
        category1.isPrivate = true

        let category2 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category2.categoryName = "Familia"
        category2.assetIdentifier = "family"
        category2.isPrivate = true
        
        let category3 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category3.categoryName = "Trabalho"
        category3.assetIdentifier = "work"
        category3.isPrivate = true
        
        let category4 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category4.categoryName = "Estudos"
        category4.assetIdentifier = "study"
        category4.isPrivate = true
        
        AudioCategoryServices().createCategory(category: category1) { _ in }
        AudioCategoryServices().createCategory(category: category2) { _ in }
        AudioCategoryServices().createCategory(category: category3) { _ in }
        AudioCategoryServices().createCategory(category: category4) { _ in }
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

        let category3 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category3.categoryName = "Piadas"
        category3.assetIdentifier = "jokes"
        category3.isPrivate = false

        let category4 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category4.categoryName = "Musicais"
        category4.assetIdentifier = "musical"
        category4.isPrivate = false

        let category5 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category5.categoryName = "Sextou!"
        category5.assetIdentifier = "friday"
        category5.isPrivate = false

        let category6 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category6.categoryName = "Áudios Resposta"
        category6.assetIdentifier = "answer"
        category6.isPrivate = false

        let category7 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category7.categoryName = "Para a família"
        category7.assetIdentifier = "family"
        category7.isPrivate = false

        let category8 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category8.categoryName = "Trotes"
        category8.assetIdentifier = "pranks"
        category8.isPrivate = false

        let category9 = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        category9.categoryName = "Quarentena"
        category9.assetIdentifier = "quarantine"
        category9.isPrivate = false
        
        AudioCategoryServices().createCategory(category: category1) { _ in }
        AudioCategoryServices().createCategory(category: category2) { _ in }
        AudioCategoryServices().createCategory(category: category3) { _ in }
        // TODO: Adicionar os outros cagoryServices
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

    // MARK: - PUBLIC AUDIOS HELPER

    func addCategoryToAudios(audios: [URL], withCategory category: AudioCategory) {
        for url in audios {
            let name = url.deletingPathExtension().lastPathComponent

            let publicAudio = Audio(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
            publicAudio.audioName = name
            publicAudio.audioPath = url.path
            publicAudio.duration = AudioManager.shared.getDurationFrom(file: url)
            publicAudio.isPrivate = false
            publicAudio.category = category
        }
    }

    let funny = [
        "Infelizmente vou ter que sair do grupo",
        "Sgonoff, feijão torpedo, pudim de leite condenado, linguiça estocana",
        "Oração contra o trabalho",
        "Nem gosto de churrasco",
        "Crianças sinceras",
        "Aviso para não saírem de casa",
        "Neiva do céu!",
        "Sai do quarto, Vinícius",
        "Segunda vai trabalhar toda desgraçada",
        "Tá em casa quietinho, né?"
    ]

    let classic = [
        "Aqui tá chovendo e repangalejando, aqui choveu e relampagou",
        "Gemidão do Zapo",
        "Cristiano Ronaldo, líder nato",
        "Oloquinho, meu!",
        "Peixoto",
        "Hoje é dia de maldade!",
        // Destaques
        "Três conchada de galinha!",
        "Ivan tentando vender queijos",
        "Seu Armando"
    ]

    let jokes = [
        "O ladrão de pato e o poeta",
        "Mensagem errada acabou matando a velha",
        "Mulher do Zé no hospital",
        "Se você ver um óculos, não pegue",
        "Piadas do Costinha",
        "Piada do chifrudo"
    ]

    let musical = [
        "Jesus humilha o Satanás",
        "Tá chovendo aí?",
        "Cantando a música do Jaspion",
        "As verdadeiras letras das músicas"
    ]

    let friday = [
        "Sextou, seus aligenigena!",
        "Hoje eu tô igual manga com ovo",
        "Nunca quis tanto que o fim chegasse",
        "Bom dia, família!"
    ]

    let answer = [
        "Oxe, e quem liga?",
        "Tá bonitão na foto, hein?",
        "Sai fora, doido",
        "Tem alguém vivo aí?",
        "Tome vergonha, vai cuidar da sua vida!",
        "Coé, rapaziada?",
        "Ah, vá à m*rda!",
        "Aplausos! Arrasou, bonita!",
        "Você é burro, cara?",
        "Mais ou menos",
        "Tu tá demais, mulher!",
        "Tudo sacanagem!",
        "Você é zueiro mesmo, hein?"
    ]

    let family = [
        "Cadê os bois?",
        "Eu gosto muito desse grupo",
        "Esse pessoal do grupo tá muito ocupado",
        "Calados do grupo, quem são?",
        "Esse grupo tá precisando de uns apito",
        "Chamando o pessoal do grupo"
    ]

    let pranks = [
        "O Vinícius fugiu!",
        "Filha passando trote no pai",
        "Quanto tá o corte de cabelo?",
        "Moça, você ligou numa hora ruim",
        "Trote do Jesus",
        "Trote na atendente da Vivo",
        "Antedeguemon"
    ]

    let quarantine = [
        "Mãe desesperada com o coronavírus",
        "Mãe surtada na quarentena",
        "Caiu auxílio emergencial",
        "Senhora enlouquecendo na quarentena",
        "A mãe do Coronga",
        "Maridos reclamando do coronavírus",
        "Gaúchos em quarentena",
        "The Walking Velho"
    ]

}
