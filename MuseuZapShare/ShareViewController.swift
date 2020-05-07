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
    var audioFileURL: URL!
    var category: AudioCategory? {
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
                                                    self.audioFileURL = url

                                                    if let err = error {
                                                        print(err)
                                                    }
        })

    }

    override func presentationAnimationDidFinish() {
        // Called after Share view is loaded
    }

    // MARK: - Share Functions

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return !contentText.isEmpty && audioFileURL != nil && category != nil
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.

        // First tries to copy file to folder. If succeeded, create entities
        do {
            try copyAudio()

            // Create Entities
            let category = AudioCategory(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
            category.categoryName = categoryText

            let audio = Audio(intoContext: CoreDataManager.sharedInstance.managedObjectContext)
            audio.audioName = contentText
            audio.audioPath = audioFileURL.path
            audio.isPrivate = true
            audio.category = category
            // TODO: Singleton de AUDIO pegar a duracao do arquivo! OU TRATAR DEPOIS tb nao sei
            audio.duration = 0

            AudioServices().createAudio(audio: audio) { (error) in
                if let err = error {
                    print(err)
                }
            }
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
        self.title = "Blin/Pleen"
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
        popConfigurationViewController()
        // TODO: prineiro coloco nome, depois seleciono categoria, quando volto botao save nao esta habilitado
        _ = isContentValid()
    }

}

// MARK: - File Exchanger

extension ShareViewController {

    /// Method that copies an AudioFile from this external application into Application Group folder
    func copyAudio() throws {

        if let audioSource = audioFileURL {
            // Create the audio name with extension
            let audioExtension = audioSource.pathExtension
            let audioName = contentText + ".\(audioExtension)"

            do {
                try FileExchanger().copyAudioToGroupFolder(sourceURL: audioSource,
                                                           destinationName: audioName)
            } catch {
                print(error)
                throw error
            }
        }
    }
}
