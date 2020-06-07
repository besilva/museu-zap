//
//  ShareViewController.swift
//  MuseuZapShare
//
//  Created by Bernardo Silva on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import Social
import AVFoundation
import DatabaseKit

class ShareViewController: SLComposeServiceViewController {

    // MARK: - Properties

    var extensionItem: NSExtensionItem?
    /// URL for audio File inside external Application (such as in WhatsApp)
    var externalAudioFileURL: URL!
    /// The correct URL that the Application can use, inside shared Application Group folder
    var appAudioFileURL: URL!
    var category: AudioCategory?
    var noCategory: AudioCategory?{
       didSet {
           guard let name = category?.categoryName else { return }
           categoryText = name
       }
    }
    var categoryText =  "Selecionar categoria" {
       didSet {
           item?.value = category?.categoryName
       }
    }
    let item = SLComposeSheetConfigurationItem()

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        AudioCategoryServices().getAllCategoriesWith(isPrivate: true) { (_, categories) in // error, categories
            if categories == nil || (categories?.count ?? 0) == 0 {
                self.addPrivateCategories()
                self.addPublicCategories()
            }
        }
        getNoCategory()
        let context = self.extensionContext
        extensionItem = context?.inputItems[0] as? NSExtensionItem
        setupNavigation()
        textView.font = UIFont.Default.regular
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeholder = "Dê um nome para o seu audio"
        extensionItem?.attachments?[0].loadItem(forTypeIdentifier: "public.file-url",
                                                options: nil,
                                                completionHandler: { (urlItem, error) in
                                                    guard let item = urlItem,
                                                          let url = URL(string: "\(item)") else { return }
                                                    // Guarantees that audioFileURL not nil
                                                    self.externalAudioFileURL = url

                                                    if let err = error {
                                                        print(err)
                                                    }
        })
        self.textView.delegate = self
    }
    
    // MARK: - Share Functions

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return !contentText.isEmpty && externalAudioFileURL != nil
    }

    /// This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    /// Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    override func didSelectPost() {

        // Tries to copy audio to folder (and if it succeeds, create the entities)
        do {
            try copyAudio()

        } catch {
            print("COULD NOT COPY AUDIO TO GROUP FOLDER")
            print(error)
        }

        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {

        item?.title = "Categoria"
        item?.value = categoryText

        item?.tapHandler = {
            let controller = CategoryTableViewController()
            controller.delegate = self
            self.pushConfigurationViewController(controller)
        }
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [item!]
    }
    
    func getNoCategory() {
        AudioCategoryServices().getAllCategoriesWith(isPrivate: true) { (_, categories) in // error, categories
            if let categories = categories {
                self.noCategory = categories.first(where: { $0.categoryName == "Sem Categoria"})
            }
        }
    }

    let imageView = UIImageView()
    override func loadPreviewView() -> UIView! {
        //        Super.loadView()

        let image = UIImage(named: "ShareIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.setupConstraints { (view) in
            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
            view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        return imageView
    }

    func setupNavigation() {
        self.title = "Blin"
        if let navBar = self.navigationController?.navigationBar {
            navBar.topItem?.leftBarButtonItem?.title = "Cancelar"
            navBar.topItem?.rightBarButtonItem?.title = "Salvar"
            navBar.tintColor = UIColor.Default.power
            navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.Default.semibold]
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Default.semibold],
                                        for: UIControl.State.normal)
            let regular = UIFont.Default.semibold
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.font: regular.withSize(17)],
                                        for: UIControl.State.disabled)
        }
    }
}

extension ShareViewController: CategoryTableViewControllerDelegate {
    func categorySelected(category: AudioCategory) {
        self.category = category
        self.textViewDidChange(self.textView)
        popConfigurationViewController()
    }

}

// MARK: - File Exchanger

extension ShareViewController {

    /// Method that copies an AudioFile from this external application into Application Group folder and create corresponding Audio Entity.
    /// appAudioFileURL contains the correct location for the Audio Entity.
    func copyAudio() throws {

        if let audioSource = externalAudioFileURL {
            // Create the audio name with extension
            let audioExtension = audioSource.pathExtension
            let audioName = contentText + ".\(audioExtension)"
            var category: AudioCategory?
            if let audioCategory = self.category {
                category = audioCategory
            } else if let audioCategory = self.noCategory {
                category = audioCategory
            }

            do {
                // Ensures that appAudioFileURL is not optional
                guard let auxURL = try FileExchanger().copyAudioToGroupFolder(sourceURL: audioSource,
                                                                             destinationName: audioName)
                else {
                    throw FileErrors.appSharedURL
                }
                self.appAudioFileURL = auxURL
                createEntities(withCategory: category)
            } catch {
                print(error)
                throw FileErrors.copy
            }
        } else {
            print("COULD NOT GET external audio URL\n")
            throw FileErrors.externalAudioURL
        }
    }

    func createEntities(withCategory audioCategory: AudioCategory?) {
        guard let audioCategory = audioCategory else { return }
        let audio = Audio(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
        audio.audioName = contentText
        audio.audioPath = appAudioFileURL.path
        // All imported audios are private
        audio.isPrivate = true
        audio.category = audioCategory
        audio.duration = AudioManager.shared.getDurationFrom(file: appAudioFileURL)

        AudioServices().createAudio(audio: audio) { (error) in
            if let err = error {
                print(err)
            }
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
       }
}
