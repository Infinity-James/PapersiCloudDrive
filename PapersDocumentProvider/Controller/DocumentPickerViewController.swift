//
//  DocumentPickerViewController.swift
//  PapersDocumentProvider
//
//  Created by James Valaitis on 29/07/2014.
//  Copyright (c) 2014 James Valaitis. All rights reserved.
//

import UIKit

class DocumentPickerViewController: UIDocumentPickerExtensionViewController
{
    @IBAction private func openDocument(sender: AnyObject?)
	{
        let documentURL = self.documentStorageURL.URLByAppendingPathComponent("Untitled.txt")
      
        // TODO: if you do not have a corresponding file provider, you must ensure that the URL returned here is backed by a file
        self.dismissGrantingAccessToURL(documentURL)
    }

    override func prepareForPresentationInMode(mode: UIDocumentPickerMode)
	{
        // TODO: present a view controller appropriate for picker mode here
    }
}