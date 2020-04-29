//
//  ShareViewController.swift
//  MuseuZapShare
//
//  Created by Bernardo Silva on 27/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    var extensionItem: NSExtensionItem?
    var filePath: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MuseuZap"
        self.placeholder = "Dê um nome para o seu audio"
        extensionItem?.attachments?[0].loadItem(forTypeIdentifier: "public.file-url", options: nil, completionHandler: { (urlItem, error) in
            if let urlItem = urlItem{
                 self.filePath = URL(string: "\(urlItem)")
            }
        })
    }
    override func loadView() {
        super.loadView()
        let context = self.extensionContext
        self.extensionItem = context?.inputItems[0] as? NSExtensionItem
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return !contentText.isEmpty
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "Categoria"
        item?.value = "Nenhuma"
        
        item?.tapHandler = {
            // TODO - : navegação
//            self.pushConfigurationViewController(<#T##viewController: UIViewController!##UIViewController!#>)
        }
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [item!]
    }
    
    override func loadPreviewView() -> UIView! {
        super.loadView()
        let view = UIImageView()
        let image = UIImage(named: "audio")
        view.setupConstraints { (view) in
            view.heightAnchor.constraint(equalToConstant: 70)
            view.widthAnchor.constraint(equalToConstant: 70)
        }
        return view
    }
}
