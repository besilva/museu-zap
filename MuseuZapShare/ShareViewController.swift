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

class ShareViewController: SLComposeServiceViewController {
    
    var extensionItem: NSExtensionItem?
    var audio: AVPlayer?
    var category: String = "Nenhuma" {
        didSet {
            item?.value = category
        }
    }
    let item = SLComposeSheetConfigurationItem()
    
    override func loadView() {
        super.loadView()
        let context = self.extensionContext
        self.extensionItem = context?.inputItems[0] as? NSExtensionItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MuseuZap"
        self.placeholder = "Dê um nome para o seu audio"
        extensionItem?.attachments?[0].loadItem(forTypeIdentifier: "public.file-url",
                                                options: nil,
                                                completionHandler: { (urlItem, error) in
            if let urlItem = urlItem,
                let url = URL(string: "\(urlItem)") {
                self.audio = AVPlayer(url: url)
            }
        })
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return !contentText.isEmpty && audio != nil
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
       
        item?.title = "Categoria"
        item?.value = category
        
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
}

extension ShareViewController: CategoryTableViewControllerDelegate {
    func categorySelected(category: String) {
        self.category = category
        popConfigurationViewController()
    }
}
