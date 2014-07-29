//
//  ViewController.swift
//  PapersiCloudDrive
//
//  Created by James Valaitis on 29/07/2014.
//  Copyright (c) 2014 James Valaitis. All rights reserved.
//

import MobileCoreServices
import UIKit

class ViewController: UIViewController
{
	var documentURL: NSURL!
	
	private var documentTypes: [String]
	{
		get
		{
			return [kUTTypeImage as NSString,
					kUTTypePDF as NSString,
					kUTTypePlainText as NSString,
					kUTTypePNG as NSString,
					kUTTypeRTF as NSString,
					kUTTypeText as NSString]
		}
	}
	
	private func displayDocumentMenuInMode(documentPickerMode: UIDocumentPickerMode, fromRect sourceRect: CGRect)
	{
		//	set up the document menu view controller and present it
		var documentMenuVC = UIDocumentMenuViewController(documentTypes: self.documentTypes, inMode: documentPickerMode)
		documentMenuVC.delegate = self
		documentMenuVC.addOptionWithTitle("New Document", image: nil, order: .First)
			{
				println("Move To Document Menu Completion Handler.")
		}
		documentMenuVC.modalPresentationStyle = .Popover
		
		self.presentViewController(documentMenuVC, animated: true)
			{
				println("Document Menu VC Presented.")
		}
		
		//	customise the presentation popover for the document menu view controller
		var presentationPopover = documentMenuVC.popoverPresentationController
		presentationPopover.permittedArrowDirections = .Down
		presentationPopover.sourceRect = sourceRect
		presentationPopover.sourceView = self.view
	}
	
	@IBAction private func exportToDocumentMenu(exportButton: UIButton)
	{
		self.displayDocumentMenuInMode(.ExportToService, fromRect: exportButton.frame)
	}
	
	@IBAction private func importFromDocumentMenu(importButton: UIButton)
	{
		self.displayDocumentMenuInMode(.Import, fromRect: importButton.frame)
	}
	
	@IBAction private func moveToDocumentMenu(moveButton: UIButton)
	{
		self.displayDocumentMenuInMode(.MoveToService, fromRect: moveButton.frame)
	}
	
	@IBAction private func openFromDocumentMenu(openButton: UIButton)
	{
		self.displayDocumentMenuInMode(.Open, fromRect: openButton.frame)
	}
	
	private func displayDocumentPickerWithDocumentTypes(documentTypes: [String], inMode documentPickerMode: UIDocumentPickerMode)
	{
		var documentPickerVC = UIDocumentPickerViewController(documentTypes: documentTypes, inMode: documentPickerMode)
		documentPickerVC.delegate = self
		self.presentViewController(documentPickerVC, animated: true)
		{
				
		}
	}
	
	private func displayDocumentPickerWithDocumentURL(documentURL: NSURL, inMode documentPickerMode: UIDocumentPickerMode)
	{
		var documentPickerVC = UIDocumentPickerViewController(URL: documentURL, inMode: documentPickerMode)
		documentPickerVC.delegate = self
		self.presentViewController(documentPickerVC, animated: true)
		{
				
		}
	}
	
	@IBAction private func exportToDocumentPicker(exportButton: UIButton)
	{
		self.displayDocumentPickerWithDocumentURL(self.documentURL, inMode: .ExportToService)
	}
	
	@IBAction private func importFromDocumentPicker(importButton: UIButton)
	{
		self.displayDocumentPickerWithDocumentTypes(self.documentTypes, inMode: .Import)
	}
	
	@IBAction private func moveToDocumentPicker(moveButton: UIButton)
	{
		self.displayDocumentPickerWithDocumentURL(self.documentURL, inMode: .MoveToService)
	}
	
	@IBAction private func openFromDocumentPicker(openButton: UIButton)
	{
		self.displayDocumentPickerWithDocumentTypes(self.documentTypes, inMode: .Open)
	}
}

extension ViewController: UIDocumentMenuDelegate
{
	func documentMenu(documentMenuVC: UIDocumentMenuViewController, didPickDocumentPicker documentPickerVC: UIDocumentPickerViewController)
	{
		documentPickerVC.delegate = self
		self.presentViewController(documentPickerVC, animated: true)
		{
				
		}
	}
	
	func documentMenuWasCancelled(documentMenuVC: UIDocumentMenuViewController)
	{
		
	}
}

extension ViewController: UIDocumentPickerDelegate
{
	func documentPicker(documentPickerVC: UIDocumentPickerViewController!, didPickDocumentAtURL url: NSURL!)
	{
		var startAccessingWorked = url.startAccessingSecurityScopedResource()
		var ubiquityURL = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
		
		var fileCoordinator = NSFileCoordinator()
		var error = NSErrorPointer()
		fileCoordinator.coordinateReadingItemAtURL(url, options: nil, error: error)
		{
			newURL in
			
			var data = NSData(contentsOfURL: newURL)
			println("Data: \(data)")
		}
		
		url.stopAccessingSecurityScopedResource()
	}
	
	func documentPickerWasCancelled(documentPickerVC: UIDocumentPickerViewController!)
	{
		
	}
}