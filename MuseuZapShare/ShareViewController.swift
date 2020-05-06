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
import Database

class ShareViewController: SLComposeServiceViewController {
    
    var extensionItem: NSExtensionItem?
    var audioFile: AVPlayer?
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
                                                    if let urlItem = urlItem,
                                                        let url = URL(string: "\(urlItem)") {
                                                        self.audioFile = AVPlayer(url: url)
                                                    }
        })
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return !contentText.isEmpty && audioFile != nil && category != nil
    }
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        let newAudio = Audio(context: CoreDataManager.sharedInstance.managedObjectContext)
//        newAudio.path = FileManager.save(audio: audio, title: title)
//        AudioServices(dao: AudioDAO()).createAudio(audio: audio, <#T##completion: ((Error?) -> Void)##((Error?) -> Void)##(Error?) -> Void#>)
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
        //        super.loadView()
        
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
    }
}
